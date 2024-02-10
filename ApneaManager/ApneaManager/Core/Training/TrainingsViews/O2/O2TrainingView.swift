//
//  CO2TrainingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData
import HealthKit




struct O2TrainingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    @Query var sessions: [Session] // Fetch all sessions
    @State private var show02TableSheet = false
    @State private var showingDetail = false
    @State private var showingSettings = false
    @State private var currentRoundIndex = 0
    @State private var o2Table: [Cycle] = []
    
    @State private var heartRate: Double? = nil
    @State private var spo2: Double? = nil
    
    /// Settings state
    @State private var totalRounds: Int = 8
    @State private var initialBreathHoldPercentage: Double = 40
    @State private var maxBreathHoldPercentage: Double = 80
    @State private var restDuration: Int = 120
    
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
                O2TrainingTimerView(o2Table: o2Table,
                                    currentRoundIndex: $currentRoundIndex,
                                    heartRate: $heartRate,
                                    spo2: $spo2
                                    ) { totalDuration in
                                        // Directly passing the o2Table of type [Cycle]
                                        saveSession(duration: totalDuration, table: o2Table, sessionType: .O2Table)
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
                // Pass the bindings to the settings view
                O2TrainingSettingsView(percentageOfPersonalBest: $initialBreathHoldPercentage,
                                       restDuration: $restDuration,
                                       totalRounds: $totalRounds)
            }
            .onChange(of: initialBreathHoldPercentage) {
                regenerateO2Table()
            }
            .onChange(of: restDuration) {
                regenerateO2Table()
            }
            .onChange(of: totalRounds) {
                regenerateO2Table()
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
    
    private func createO2Table(personalBest: Int) -> [Cycle] {
        let totalRounds = self.totalRounds
        let initialBreathHoldPercentage = self.initialBreathHoldPercentage / 100 // Ensure this is a decimal
        let maxBreathHoldPercentage = self.maxBreathHoldPercentage / 100 // Ensure this is a decimal
        let initialBreathHoldDuration = Int(Double(personalBest) * initialBreathHoldPercentage)
        let maxBreathHoldDuration = Int(Double(personalBest) * maxBreathHoldPercentage)
        let restDuration = self.restDuration
        
        var cycles: [Cycle] = []
        var currentHoldDuration = initialBreathHoldDuration
        // Ensure this calculation does not result in a zero or negative value
        /// Increase per round time is calculated here
        let increasePerRound = max((maxBreathHoldDuration - initialBreathHoldDuration) / max(1, totalRounds - 1), 1)
        
        for roundIndex in 1...totalRounds {
            // Check if currentHoldDuration exceeds maxBreathHoldDuration and set to max if it does
            if currentHoldDuration > maxBreathHoldDuration {
                currentHoldDuration = maxBreathHoldDuration
            }
            
            cycles.append(Cycle(hold: currentHoldDuration, rest: restDuration))
            
            // Only increase if below max duration
            if currentHoldDuration < maxBreathHoldDuration {
                currentHoldDuration += increasePerRound
            }
            // Debug print to monitor values
            print("DEBUG: Your personal best hold being used is \(personalBest) and your initial breath hold duration is \(initialBreathHoldDuration) which should be \(initialBreathHoldPercentage) of your personal best and max breath hold duration of \(maxBreathHoldDuration) which is 80% of you pb.")
            print("Round \(roundIndex): Hold = \(currentHoldDuration), Increase = \(increasePerRound)")
        }
        
        return cycles
    }

    
    private func regenerateO2Table() {
        if let personalBest = longestBreathHoldDuration {
            o2Table = createO2Table(personalBest: personalBest)
            print(o2Table)
        }
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
    
    func saveSession(duration: Int, table: [Cycle], sessionType: Session.SessionType) {
        // Serialize the table data to a JSON string
        guard let jsonData = try? JSONEncoder().encode(table) else {
            print("Failed to serialize table data")
            return
        }
        
        let jsonString = String(data: jsonData, encoding: .utf8)
        
        let newSession = Session(
            image: "freediver-8", // Example image property, adjust as needed
            sessionType: sessionType,
            duration: duration,
            tableData: jsonString // Save the serialized table data
        )
        // Assuming `context` is your SwiftData context
        context.insert(newSession)
        print("Training session saved with duration: \(duration) and table data for \(sessionType.rawValue): \(String(describing: jsonString)).")
    }



}
    
#Preview {
    O2TrainingView()
}
    
    

struct O2TrainingTimerView: View {
    @Environment(\.selectedTheme) var theme: Theme
    var o2Table: [Cycle]
    @Binding var currentRoundIndex: Int
    @Binding var heartRate: Double?
    @Binding var spo2: Double?
    @State private var errorMessage: String?
    
    @State private var progress: CGFloat = 0
    @State private var elapsedTime: CGFloat = 0
    @State private var totalDuration: CGFloat = 0 // Track total duration accurately
    @State private var isActive = false
    @State private var isHoldPhase = true //changes initial start phase
    @State private var phaseTimeRemaining: CGFloat = 0
    @State private var healthDataFetchTimer: Timer? = nil
    
    var onSave: (Int) -> Void
    
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    // Left side content (Heart Rate)
                    VStack {
                        if let heartRate = heartRate {
                            Text("HR: \(Int(heartRate)) bpm")
                        } else {
                            Text("HR: --")
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading) // Use dynamic width for alignment

                    // Center content (Start Button)
                    Button(action: toggleTimer) {
                        Text(isActive ? "Stop" : "Start")
                            .font(.title)
                            .bold()
                            .padding()
                            .background(isActive ? Color.red : theme.mainColor)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .frame(width: 120) // Fixed width for the button for consistent sizing

                    // Right side content (SpO2)
                    VStack {
                        if let spo2 = spo2 {
                            Text("SpO2: \(Int(spo2))%")
                        } else {
                            Text("SpO2: --")
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing) // Use dynamic width for alignment

                }
                .padding(.bottom)

                // Remaining components (progress circle, etc.)
            }
            .padding(.horizontal) // Ensure there's padding around the HStack to prevent edge content from touching the sides

            
            ZStack {
                Circle()
                    .stroke(lineWidth: 24)
                    .opacity(0.1)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(theme.mainColor)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: progress)
                
                VStack {
                    Text(phaseIndicatorText())
                        .font(.title)
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                        .background(phaseIndicatorColor().opacity(0.5))
                        .cornerRadius(8)
                    
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
        .onAppear {
            requestHealthData()
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
            // Start or resume the training session
            setPhaseTime()
            startHealthDataFetchTimer() // Start fetching health data when the timer is active
        } else {
            // Pause or stop the training session
            stopHealthDataFetchTimer() // Stop fetching health data when the timer is inactive
            // Include the last active phase's elapsedTime before saving
            totalDuration += elapsedTime
            onSave(Int(totalDuration))
            resetTimer()
        }
    }
    
    private func startHealthDataFetchTimer() {
        // Invalidate existing timer if any to avoid duplicate timers
        stopHealthDataFetchTimer()

        // Schedule a new timer
        healthDataFetchTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
            print("Fetching health data...") // Debugging line
            requestHealthData()
        }
    }

    private func stopHealthDataFetchTimer() {
        healthDataFetchTimer?.invalidate()
        healthDataFetchTimer = nil
    }


    
    private func setPhaseTime() {
        if currentRoundIndex < o2Table.count {
            let phaseDuration = isHoldPhase ? o2Table[currentRoundIndex].hold : o2Table[currentRoundIndex].rest
            phaseTimeRemaining = CGFloat(phaseDuration)
            progress = 0
            elapsedTime = 0
        }
    }
    
    private func requestHealthData() {
        let healthKitManager = HealthKitManager()
        
        healthKitManager.fetchLatestHeartRate { rate, error in
            if let rate = rate {
                DispatchQueue.main.async {
                    print("Fetched heart rate: \(rate)")
                    self.heartRate = rate
                }
            } else if let error = error {
                print("Error fetching heart rate: \(error.localizedDescription)")
            }
        }

        healthKitManager.fetchLatestSpO2 { spo2Value, error in
            if let spo2Value = spo2Value {
                DispatchQueue.main.async {
                    print("Fetched SpO2: \(spo2Value)")
                    self.spo2 = spo2Value
                }
            } else if let error = error {
                print("Error fetching SpO2: \(error.localizedDescription)")
            }
        }

    }
    
    private func resetTimer() {
        elapsedTime = 0
        progress = 0
        isHoldPhase = true
        totalDuration = 0 // Reset total duration for a new session
        currentRoundIndex = 0 // Reset to start from the first round
    }
    
    
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
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
    
    
    
    
}
    
