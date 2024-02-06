//
//  CO2TrainingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData

struct CO2TrainingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    
    @Query var sessions: [Session] // Fetch all sessions
    @State private var showC02TableSheet = false
    @State private var showingDetail = false
    @State private var showingSettings = false
    @State private var currentRoundIndex = 0
    @State private var co2Table: [(hold: Int, rest: Int)] = []
    @State private var totalTrainingDuration: Int = 0
    
    private var longestBreathHoldDuration: Int? {
        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
        return breathHoldSessions.map { $0.duration }.max() // Assuming 'duration' is a property of Session
    }
    
    private var roundsElapsed: Int {
        return currentRoundIndex
    }
    
    private var roundsRemaining: Int {
        return max(0, co2Table.count - roundsElapsed)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // Display the header with elapsed and remaining rounds
                TrainingHeaderView(roundsElapsed: roundsElapsed, roundsRemaining: roundsRemaining)
                
                // Display the CO2 training timer
                CO2TrainingTimerView(co2Table: co2Table, currentRoundIndex: $currentRoundIndex)
                
                // HStack for buttons
                HStack {
                    Button("Settings") {
                        showingSettings = true
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
            .navigationTitle("CO2 Table Training")
            .onAppear {
                if let personalBest = longestBreathHoldDuration {
                    co2Table = createCO2Table(personalBest: personalBest)
                }
            }
//            .onDisappear {
//                if isActive {
//                    endCO2TrainingSession()
//                }
//            }
            .sheet(isPresented: $showingSettings) {
                CO2TrainingSettingsView()
            }
            .sheet(isPresented: $showingDetail) {
                CO2TrainingDetailView()
            }
            .sheet(isPresented: $showC02TableSheet) {
                CO2TrainingTableDetailView(co2Table: co2Table)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showC02TableSheet = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
    }
    
    private func createCO2Table(personalBest: Int) -> [(hold: Int, rest: Int)] {
            let initialBreathHoldDuration = Int(Double(personalBest) * 0.6) // 60% of personal best
            let initialRestDuration = initialBreathHoldDuration + 15 // 15 seconds more than hold duration
            let reductionPerRound = 5 // Reduce rest by 5 seconds each round
            let totalRounds = 8 // Total number of rounds
            
            var table: [(hold: Int, rest: Int)] = []
            var currentRestDuration = initialRestDuration
            
            for _ in 1...totalRounds {
                table.append((hold: initialBreathHoldDuration, rest: currentRestDuration))
                currentRestDuration = max(15, currentRestDuration - reductionPerRound) // Rest duration should not go below 15 seconds
            }
            print("DEBUG: Your personal best hold being used is \(personalBest) and your initial breath hold duration is \(initialBreathHoldDuration) which should be 60% of your personal best.")
            print(table)
            return table
            
        }
    
//    func endCO2TrainingSession() {
//        // Ensure that there is data to save
//        guard !co2Table.isEmpty else { return }
//
//        // Calculate the total duration of the CO2 session
//        let totalDuration = co2Table.reduce(0) { $0 + $1.hold + $1.rest }
//
//        // Create a new Session instance
//        let newSession = Session(
//            image: "freediver-4", // Replace with actual image name
//            sessionType: .Co2Table,
//            duration: totalDuration + totalTrainingDuration // Add total training duration
//        )
//
//        // Save the session using SwiftData
//        context.insert(newSession)
//        print("CO2 training session saved with total duration: \(totalDuration + totalTrainingDuration)")
//    }



    
}

#Preview {
    CO2TrainingView()
}


struct CO2TrainingTimerView: View {
    var co2Table: [(hold: Int, rest: Int)]
    @Binding var currentRoundIndex: Int
    @Environment(\.modelContext) private var context
    @State private var totalTrainingDuration: Int = 0
    
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
            // If the timer is started, initialize the phase time without resetting the total elapsed time
            setPhaseTime(initialize: true)
        } else {
            // If the timer is stopped manually, call endCO2TrainingSession and then reset
            endCO2TrainingSession()
            resetTimer()
        }
    }

    private func setPhaseTime(initialize: Bool = false) {
        if currentRoundIndex < co2Table.count {
            let phaseDuration = isHoldPhase ? co2Table[currentRoundIndex].hold : co2Table[currentRoundIndex].rest
            phaseTimeRemaining = CGFloat(phaseDuration)
            if initialize {
                progress = 0
                // Do not reset elapsedTime here to keep accumulating total session duration
            }
        }
    }

    private func resetTimer() {
        // Reset only when the session completely ends or is manually stopped
        elapsedTime = 0
        progress = 0
        isHoldPhase = true
        currentRoundIndex = 0 // Ensure this resets to allow restarting the session
    }
    
    private func updateProgress() {
        elapsedTime += 0.05
        phaseTimeRemaining -= 0.05
        
        let totalPhaseTime = isHoldPhase ? CGFloat(co2Table[currentRoundIndex].hold) : CGFloat(co2Table[currentRoundIndex].rest)
        progress = (totalPhaseTime - phaseTimeRemaining) / totalPhaseTime
        
        if phaseTimeRemaining <= 0 {
            if isHoldPhase {
                isHoldPhase = false
                setPhaseTime()
            } else {
                isHoldPhase = true
                currentRoundIndex += 1
                if currentRoundIndex >= co2Table.count {
                    // Session ends, so we call endCO2TrainingSession and reset timer
                    isActive = false
                    endCO2TrainingSession()
                    resetTimer()
                } else {
                    setPhaseTime()
                }
            }
        }
    }

    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func endCO2TrainingSession() {
        // Ensure that there is data to save
        guard !co2Table.isEmpty else { return }

        // Calculate the total duration of the CO2 session
        let totalDuration = Int(elapsedTime)

        // Create a new Session instance
        let newSession = Session(
            image: "freediver-4", // Replace with actual image name
            sessionType: .Co2Table,
            duration: totalDuration  // Add total training duration
        )

        // Save the session using SwiftData
        context.insert(newSession)
        print("CO2 training session saved with total duration: \(totalDuration)")
    }
}



