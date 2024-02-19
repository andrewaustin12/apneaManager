import SwiftUI
import AudioToolbox

struct SquareBreathingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    @State private var isUserPro: Bool = false
    
    @State private var showingDetail = false
    @State private var showingSettingsSheet = false
    @State private var detailViewType: String = ""
    
    @State private var phase: String = "Ready"
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    @State private var phaseDuration: Int = 4 // Duration for each phase in seconds
    @State private var totalDuration: Int = 5 * 60 // Default total duration is 10 minutes
    @State private var tenSecondSoundPlayed = false
    @State private var currentPhaseIndex = 0
    @State private var elapsedTime = 0
    @State private var showAlert = false
    
    @State private var startTime: Date?
    
    let phases = ["Inhale", "Hold", "Exhale", "Hold"]
    let colors = [Color.green, Color.blue, Color.red, Color.yellow]
    let theme: Theme
    @State private var isExerciseActive = false
    
    private var progress: Double {
        guard let startTime = startTime else { return 0 }
        let elapsed = Date().timeIntervalSince(startTime)
        return min(elapsed / Double(totalDuration), 1) // Ensure progress does not exceed 1
    }
    
    // Utility function to format duration in "X min Y sec" format, or just "X min" if Y is 0
    private func formatDuration(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        if seconds == 0 {
            return "\(minutes) min" // Only show minutes if there are no remaining seconds
        } else {
            return "\(minutes) min \(seconds) sec" // Show both minutes and seconds
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    // Progress View
                    ProgressView(value: progress)
                        .progressViewStyle(TrainingProgressViewStyle(theme: theme))
                    
                    
                    HStack {
                        VStack(alignment:.leading) {
                            Text("Phase Duration")
                                .font(.caption)
                            Label("\(phaseDuration)", systemImage: "hourglass.tophalf.fill")
                                .labelStyle(.trailingIcon)
                        }
                        
                        Spacer()
                        VStack(alignment:.trailing) {
                            Text("Total Training Time")
                                .font(.caption)
                            Label(formatDuration(totalDuration), systemImage: "hourglass.bottomhalf.fill")
                                .labelStyle(.trailingIcon)
                        }
                    }
                }
                .padding([.top, .horizontal])
                
                VStack {
                    HStack {
                        Button(action: toggleBreathingExercise) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(isExerciseActive ? Color.red : theme.mainColor)
                                    .frame(width: 100, height: 50)
                                    .shadow(radius: 10)
                                
                                Text(isExerciseActive ? "Stop" : "Start")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.white)
                            }
                        }
                        
                        .animation(.easeInOut, value: isExerciseActive)
                        .scaleEffect(isExerciseActive ? 1.1 : 1.0)
                    }
                    .padding(.vertical)
                    
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 20)
                            .opacity(0.3)
                            .foregroundColor(colors[currentPhaseIndex % colors.count])
                        
                        Text(phase)
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(colors[currentPhaseIndex % colors.count])
                        
                        Text("\(timeRemaining)s")
                            .font(.system(size: 20))
                            .padding(.top, 60)
                    }
                    .frame(width: 320, height: 320)
                    .padding()
                    
                    Spacer()
                }
                
                // HStack for buttons
                HStack {
                    Button("Settings") {
                        showingSettingsSheet = true
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
            .navigationTitle("Square Breath Training")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Timer Complete"),
                    message: Text("Your session is complete."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showingDetail) {
                SquareBreathingDetailView()
            }
            .sheet(isPresented: $showingSettingsSheet, content: {
                SquareBreathingSettingsView(phaseDuration: $phaseDuration, totalDuration: $totalDuration)
            })
            
        }
    }
    
    private func toggleBreathingExercise() {
        if isExerciseActive {
            stopBreathingExercise()
        } else {
            startBreathingExercise()
        }
    }
    
    func startBreathingExercise() {
        startTime = Date() // Record the start time
        resetTimer()
        currentPhaseIndex = 0
        moveToNextPhase()
        isExerciseActive = true
    }
    
    func stopBreathingExercise() {
        timer?.invalidate()
        timer = nil
        phase = "Ready" // resets phase to Ready
        isExerciseActive = false // resets stop to Start
        if let start = startTime {
            let duration = Date().timeIntervalSince(start)
            saveSession(duration: Int(duration))
        }
        timeRemaining = phaseDuration // Reset time remaining to phase duration
        elapsedTime = 0 // Reset elapsed time
        startTime = nil // Ensure start time is reset for the next session
        currentPhaseIndex = 0 // Optionally reset the phase index
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timeRemaining = phaseDuration
    }
    
//    private func moveToNextPhase() {
//        if startTime == nil { startTime = Date() } // Start the timer if not already started
//        
//        phase = phases[currentPhaseIndex % phases.count]
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            guard let startTime = self.startTime else { return }
//            
//            let elapsedTime = Date().timeIntervalSince(startTime)
//            let timeLeft = self.totalDuration - Int(elapsedTime)
//            
//            let enableMinuteNotification = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isMinuteNotificationChecked)
//            let enable10SecondsNotification = UserDefaults.standard.bool(forKey: UserDefaults.Keys.is10SecondsNotificationChecked)
//            
//            if elapsedTime >= Double(self.totalDuration) {
//                self.stopBreathingExercise() // Automatically stop if total duration reached
//                showAlert = true
//                return
//            }
//            
//            self.timeRemaining -= 1
//            
//            // Minute Notification is one ding
//            if enableMinuteNotification && timeLeft % 60 == 0 && timeLeft != self.totalDuration && timeLeft > 10 {
//                AudioServicesPlaySystemSound(1052) // Adjust sound ID accordingly
//            }
//            
//            // 10 Seconds Notification is two
//            if enable10SecondsNotification && timeLeft == 10 {
//                AudioServicesPlaySystemSound(1052) // Play twice for two dings
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    AudioServicesPlaySystemSound(1052)
//                }
//            }
//            
//            if self.timeRemaining <= 0 {
//                self.currentPhaseIndex += 1
//                if self.currentPhaseIndex >= self.phases.count {
//                    self.currentPhaseIndex = 0 // Restart or adjust as necessary
//                }
//                self.phase = self.phases[self.currentPhaseIndex % self.phases.count]
//                self.timeRemaining = self.phaseDuration // Reset the timer for the next phase
//            }
//        }
//    }
    
    private func moveToNextPhase() {
        if startTime == nil { startTime = Date() } // Start the timer if not already started
        
        phase = phases[currentPhaseIndex % phases.count]
        let initialTime = self.totalDuration // Capture the initial total duration for comparison
        var minuteSoundPlayed = false // To manage minute sound play
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let startTime = self.startTime else { return }
            
            let elapsedTime = Date().timeIntervalSince(startTime)
            let timeLeft = self.totalDuration - Int(elapsedTime)
            
            let enableMinuteNotification = UserDefaults.standard.bool(forKey: UserDefaults.Keys.isMinuteNotificationChecked)
            let enable10SecondsNotification = UserDefaults.standard.bool(forKey: UserDefaults.Keys.is10SecondsNotificationChecked)
            
            if elapsedTime >= Double(self.totalDuration) {
                self.stopBreathingExercise() // Automatically stop if total duration reached
                self.showAlert = true
                return
            }
            
            self.timeRemaining -= 1
            
            // Minute Notification is one ding
            if enableMinuteNotification && timeLeft % 60 == 0 && timeLeft != initialTime && timeLeft > 10 && !minuteSoundPlayed {
                AudioServicesPlaySystemSound(1052) // Adjust sound ID accordingly
                minuteSoundPlayed = true // Prevents the sound from playing more than once per minute
            } else if timeLeft % 60 == 59 {
                minuteSoundPlayed = false // Reset the flag one second before the next minute starts
            }
            
            // 10 Seconds Notification is two dings
            if enable10SecondsNotification && timeLeft == 10 {
                AudioServicesPlaySystemSound(1052) // Play first ding for 10 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    AudioServicesPlaySystemSound(1052) // Play second ding
                }
            }
            
            if self.timeRemaining <= 0 {
                self.currentPhaseIndex += 1
                if self.currentPhaseIndex >= self.phases.count {
                    self.currentPhaseIndex = 0 // Restart or adjust as necessary
                }
                self.phase = self.phases[self.currentPhaseIndex % self.phases.count]
                self.timeRemaining = self.phaseDuration // Reset the timer for the next phase
            }
        }
    }

    
    private func saveSession(duration: Int) {
        // Ensure the duration is not negative
        let validDuration = max(0, duration)
        let newSession = Session(
            date: Date(),
            image: "freediver-4",
            sessionType: .squareBreath,
            duration: validDuration
        )
        // Save the session using SwiftData
        context.insert(newSession)
        print("DEBUG: New square breathing session added! Session length: \(validDuration) seconds")
    }
    
}

#Preview {
    NavigationStack {
        SquareBreathingView(theme: .bubblegum)
            .modelContainer(for: Session.self)
    }
}
