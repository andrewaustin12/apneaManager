//
//  CO2TrainingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData

struct O2TrainingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    @Query var sessions: [Session] // Fetch all sessions
    @State private var show02TableSheet = false
    @State private var showingDetail = false
    @State private var currentRoundIndex = 0
    @State private var o2Table: [(hold: Int, rest: Int)] = []
    
    private var longestBreathHoldDuration: Int? {
        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
        return breathHoldSessions.map { $0.duration }.max() // Assuming 'duration' is a property of Session
    }
    
    private var roundsElapsed: Int {
        return currentRoundIndex
    }
    
    private var roundsRemaining: Int {
        return max(0, o2Table.count - roundsElapsed)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Display the header with elapsed and remaining rounds
                TrainingHeaderView(roundsElapsed: roundsElapsed, roundsRemaining: roundsRemaining)
                
                // Display the CO2 training timer
                O2TrainingTimerView(o2Table: o2Table, currentRoundIndex: $currentRoundIndex)
                
                // HStack for buttons
                HStack {
                    Button("Table Plan") {
                        show02TableSheet = true
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    
                    Spacer()
                    
                    Button("Guidance") {
                        showingDetail = true
                    }
                    .padding()
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("O2 Table Training")
            .onAppear {
                if let personalBest = longestBreathHoldDuration {
                    o2Table = createO2Table(personalBest: personalBest)
                }
            }
//            .onDisappear {
//                if isActive {
//                    endCO2TrainingSession()
//                }
//            }
            .sheet(isPresented: $showingDetail) {
                O2TrainingDetailView()
            }
            .sheet(isPresented: $show02TableSheet) {
                O2TrainingTableDetailView(o2Table: o2Table)
            }
            
        }
    }
    
    private func createO2Table(personalBest: Int) -> [(hold: Int, rest: Int)] {
        let totalRounds = 8
        let initialBreathHoldPercentage = 0.4 // Starting at 40% of personal best
        let maxBreathHoldPercentage = 0.8 // Maximum at 80% of personal best
        let initialBreathHoldDuration = Int(Double(personalBest) * initialBreathHoldPercentage)
        let maxBreathHoldDuration = Int(Double(personalBest) * maxBreathHoldPercentage)
        let restDuration = 120 // Consistent 2-minute rest between holds

        var table: [(hold: Int, rest: Int)] = []
        var currentHoldDuration = initialBreathHoldDuration
        let increasePerRound = (maxBreathHoldDuration - initialBreathHoldDuration) / (totalRounds - 1)

        for _ in 1...totalRounds {
            table.append((hold: currentHoldDuration, rest: restDuration))
            currentHoldDuration = min(currentHoldDuration + increasePerRound, maxBreathHoldDuration)
        }

        print("DEBUG: O2 table created with initial hold of \(initialBreathHoldDuration) seconds and max hold of \(maxBreathHoldDuration) seconds.")
        return table
    }

    
//    func endCO2TrainingSession() {
//        // Ensure that there is data to save
//        guard !co2Table.isEmpty else { return }
//
//        // Convert [(hold: Int, rest: Int)] to [Cycle]
//        let cycles = co2Table.map { Cycle(hold: $0.hold, rest: $0.rest) }
//
//        // Create a CO2Table instance with the converted CO2 table data
//        let co2TableInstance = CO2Table(cycles: cycles)
//
//        // Calculate the total duration of the CO2 session
//        let totalDuration = cycles.reduce(0) { $0 + $1.hold + $1.rest }
//
//        // Create a new Session instance
//        let newSession = Session(
//            image: "your_image_name", // Replace with actual image name
//            sessionType: .Co2Table,
//            duration: totalDuration,
//            co2Table: co2TableInstance
//        )
//
//        // Save the session using SwiftData
//        context.insert(newSession)
//        print("CO2 training session saved with CO2 table: \(co2TableInstance)")
//    }


    
}

//#Preview {
//    CO2TrainingView(sessions: <#[Session]#>)
//}


struct O2TrainingTimerView: View {
    var o2Table: [(hold: Int, rest: Int)]
    @Binding var currentRoundIndex: Int
    
    @State private var progress: CGFloat = 0
    @State private var elapsedTime: CGFloat = 0
    @State private var isActive = false
    @State private var isHoldPhase = true
    @State private var phaseTimeRemaining: CGFloat = 0
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            // Start/Stop Button
            Button(action: toggleTimer) {
                Text(isActive ? "Stop" : "Start")
                    .font(.title)
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            
            // Circular Progress
            ZStack {
                Circle()
                    .stroke(lineWidth: 24)
                    .opacity(0.1)
                    .foregroundColor(Color.gray)
                
                CircleProgressShape(progress: progress)
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: progress)
                
                // Time Display
                VStack {
                    // Phase Indicator
                    Text(phaseIndicatorText())
                        .font(.headline)
                        .foregroundColor(phaseIndicatorColor())
                        .padding()
                        .background(phaseIndicatorColor().opacity(0.2))
                        .cornerRadius(10)
                        .padding(.bottom, 5)
                    
                    Text(timeString(from: elapsedTime))
                        .font(.largeTitle)
                        .bold()
                }
            }
            .padding(.horizontal)
            
            
        }
        .onReceive(timer) { _ in
            guard isActive else { return }
            updateProgress()
        }
    }
    
    private func phaseIndicatorText() -> String {
        if !isActive {
            return "Ready"
        }
        return isHoldPhase ? "Hold" : "Breath"
    }
    
    private func phaseIndicatorColor() -> Color {
        if !isActive {
            return Color.gray
        }
        return isHoldPhase ? Color.red : Color.green
    }
    
    private func toggleTimer() {
        isActive.toggle()
        if isActive {
            setPhaseTime()
        } else {
            resetTimer()
        }
    }
    
    private func setPhaseTime() {
        if currentRoundIndex < o2Table.count {
            let phaseDuration = isHoldPhase ? o2Table[currentRoundIndex].hold : o2Table[currentRoundIndex].rest
            phaseTimeRemaining = CGFloat(phaseDuration)
            progress = 0
            elapsedTime = 0
        }
    }
    
    private func resetTimer() {
        elapsedTime = 0
        progress = 0
        isHoldPhase = true
    }
    
    private func updateProgress() {
        elapsedTime += 0.05
        phaseTimeRemaining -= 0.05
        
        let totalPhaseTime = isHoldPhase ? CGFloat(o2Table[currentRoundIndex].hold) : CGFloat(o2Table[currentRoundIndex].rest)
        progress = (totalPhaseTime - phaseTimeRemaining) / totalPhaseTime
        
        if phaseTimeRemaining <= 0 {
            if isHoldPhase {
                isHoldPhase = false
                setPhaseTime()
            } else {
                isHoldPhase = true
                currentRoundIndex += 1
                if currentRoundIndex < o2Table.count {
                    setPhaseTime()
                } else {
                    isActive = false
                    resetTimer()
                }
            }
        }
    }
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}



