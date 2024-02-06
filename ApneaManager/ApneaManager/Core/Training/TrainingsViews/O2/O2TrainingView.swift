//
//  CO2TrainingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData

struct Cycle {
    var hold: Int
    var rest: Int
}


struct O2TrainingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    @Query var sessions: [Session] // Fetch all sessions
    @State private var show02TableSheet = false
    @State private var showingDetail = false
    @State private var showingSettings = false
    @State private var currentRoundIndex = 0
    @State private var o2Table: [(hold: Int, rest: Int)] = []
    
    //@State private var initialBreathHoldDuration: Double = 0.4
    
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
                    .padding(.bottom)
                
                // Display the CO2 training timer
                O2TrainingTimerView(o2Table: o2Table, currentRoundIndex: $currentRoundIndex) { totalDuration in
                    saveSession(duration: totalDuration)
                }
                Spacer()
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
            .navigationTitle("O2 Table Training")
            .onAppear {
                if let personalBest = longestBreathHoldDuration {
                    o2Table = createO2Table(personalBest: personalBest)
                }
            }
            .sheet(isPresented: $showingSettings) {
                O2TrainingSettingsView()
            }
            .sheet(isPresented: $showingDetail) {
                O2TrainingDetailView()
            }
            .sheet(isPresented: $show02TableSheet) {
                O2TrainingTableDetailView(o2Table: o2Table)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        show02TableSheet = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                }
            }
        }
    }
    
    private func createO2Table(personalBest: Int) -> [(hold: Int, rest: Int)] {
        let totalRounds = 2
        let initialBreathHoldPercentage = 0.4 // Starting at 40% of personal best
        let maxBreathHoldPercentage = 0.8 // Maximum at 80% of personal best
        let initialBreathHoldDuration = Int(Double(personalBest) * initialBreathHoldPercentage)
        let maxBreathHoldDuration = Int(Double(personalBest) * maxBreathHoldPercentage)
        let restDuration = 120 // Consistent 2-minute rest between holds
        
        var o2table: [(hold: Int, rest: Int)] = []
        var currentHoldDuration = initialBreathHoldDuration
        let increasePerRound = (maxBreathHoldDuration - initialBreathHoldDuration) / (totalRounds - 1)
        
        for _ in 1...totalRounds {
            o2table.append((hold: currentHoldDuration, rest: restDuration))
            currentHoldDuration = min(currentHoldDuration + increasePerRound, maxBreathHoldDuration)
        }
        
        print("DEBUG: O2 table created using your PB of \(personalBest) with initial hold of \(initialBreathHoldDuration) seconds which is 40% of pb and max hold of \(maxBreathHoldDuration) seconds which is 80% of pb.")
        print(o2table)
        return o2table
    }
    
    
    func endO2TrainingSession() {
        // Ensure that there is data to save
        guard !o2Table.isEmpty else { return }
        
        // Convert [(hold: Int, rest: Int)] to [Cycle]
        let cycles = o2Table.map { Cycle(hold: $0.hold, rest: $0.rest) }
        
        // Assuming you need to calculate the total duration and then create a session or similar entity
        let totalDuration = cycles.reduce(0) { $0 + $1.hold + $1.rest }
        
        // Create a new Session instance (adjust according to your model)
        let newSession = Session(
            image: "freediver-8", // Example property
            sessionType: .O2Table, // Example property, adjust as necessary
            duration: totalDuration
            // Add here any property or method call that uses `cycles`
            // For example, if you have a property in Session to hold cycles, set it here
        )
        
        // Save the session using SwiftData
        context.insert(newSession)
        print("O2 training session saved with a duration of \(totalDuration)")
    }
    
    func saveSession(duration: Int) {
        let newSession = Session(
            image: "freediver-8",  // Example image property
            sessionType: .O2Table, // Session type indicating this is an O2Table session
            duration: duration     // The total elapsed time passed to this function
        )
        // Save the session using SwiftData (or your context management strategy)
        context.insert(newSession)
        print("O2 training session saved with a duration of \(duration)")
        
    }
}
    
#Preview {
    O2TrainingView()
}
    
    

struct O2TrainingTimerView: View {
    var o2Table: [(hold: Int, rest: Int)]
    @Binding var currentRoundIndex: Int
    
    @State private var progress: CGFloat = 0
    @State private var elapsedTime: CGFloat = 0
    @State private var totalDuration: CGFloat = 0 // Track total duration accurately
    @State private var isActive = false
    @State private var isHoldPhase = true
    @State private var phaseTimeRemaining: CGFloat = 0
    
    var onSave: (Int) -> Void
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Button(action: toggleTimer) {
                Text(isActive ? "Stop" : "Start")
                    .font(.title)
                    .bold()
                    .padding()
                    .background(isActive ? Color.red : Color.green)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.vertical)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 24)
                    .opacity(0.1)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: progress)
                
                VStack {
                    Text(phaseIndicatorText())
                        .font(.headline)
                        .padding()
                        .background(phaseIndicatorColor().opacity(0.2))
                        .cornerRadius(10)
                    
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
        return isHoldPhase ? "Hold" : "Breathe"
    }
    
    private func phaseIndicatorColor() -> Color {
        if !isActive {
            return Color.gray
        }
        return isHoldPhase ? Color.purple : Color.green
    }
    
    private func toggleTimer() {
        isActive.toggle()
        if isActive {
            setPhaseTime()
        } else {
            // Include the last active phase's elapsedTime before saving
            totalDuration += elapsedTime
            onSave(Int(totalDuration))
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
        totalDuration = 0 // Reset total duration for a new session
        currentRoundIndex = 0 // Reset to start from the first round
    }
    
    private func updateProgress() {
        elapsedTime += 0.05
        phaseTimeRemaining -= 0.05
        
        let totalPhaseTime = isHoldPhase ? CGFloat(o2Table[currentRoundIndex].hold) : CGFloat(o2Table[currentRoundIndex].rest)
        progress = (totalPhaseTime - phaseTimeRemaining) / totalPhaseTime
        
        if phaseTimeRemaining <= 0 {
            totalDuration += totalPhaseTime // Add completed phase time to total duration
            
            if isHoldPhase {
                isHoldPhase = false
                elapsedTime = 0
                setPhaseTime()
            } else {
                isHoldPhase = true
                currentRoundIndex += 1
                if currentRoundIndex < o2Table.count {
                    elapsedTime = 0
                    setPhaseTime()
                } else {
                    isActive = false
                    // Save the session here to include the duration of the last phase
                    onSave(Int(totalDuration))
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
    
