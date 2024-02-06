import SwiftUI

struct SquareBreathingView: View {
    // Model state
    @Environment(\.modelContext) private var context
    
    @State private var showingDetail = false
    @State private var showingSettingsSheet = false
    @State private var detailViewType: String = ""
    
    @State private var phase: String = "Ready"
    @State private var timeRemaining: Int = 0
    @State private var timer: Timer?
    @State private var phaseDuration: Int = 4 // Duration for each phase in seconds
    @State private var totalDuration: Int = 5 * 60 // Default total duration is 10 minutes
    @State private var currentPhaseIndex = 0
    @State private var elapsedTime = 0
    
    @State private var startTime: Date?
    
    let phases = ["Inhale", "Hold", "Exhale", "Hold"]
    let colors = [Color.blue, Color.green, Color.red, Color.yellow]
    
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
                        .progressViewStyle(TrainingProgressViewStyle())
                    
                    
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
                    
                    
                    Spacer()
                    
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
                    
                    HStack {
                        Button(action: startBreathingExercise) {
                            Text("Start")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(8)
                        }
                        
                        Button(action: stopBreathingExercise) {
                            Text("Stop")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    }
                    
                    
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
            
            .sheet(isPresented: $showingDetail) {
                SquareBreathingDetailView()
            }
            .sheet(isPresented: $showingSettingsSheet, content: {
                SquareBreathingSettingsView(phaseDuration: $phaseDuration, totalDuration: $totalDuration)
            })
            
        }
    }
    
    func startBreathingExercise() {
        startTime = Date() // Record the start time
        resetTimer()
        currentPhaseIndex = 0
        moveToNextPhase()
    }
    
    
    func stopBreathingExercise() {
        timer?.invalidate()
        timer = nil
        phase = "Ready"
        
        if let start = startTime {
            let duration = Date().timeIntervalSince(start)
            saveSession(duration: Int(duration))
        }
        startTime = nil // Ensure start time is reset for the next session
        currentPhaseIndex = 0 // Optionally reset the phase index
    }
    
    
    
    
    private func resetTimer() {
        timer?.invalidate()
        timeRemaining = phaseDuration
    }
    
    private func moveToNextPhase() {
        if startTime == nil { startTime = Date() } // Start the timer if not already started
        
        phase = phases[currentPhaseIndex % phases.count]
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            guard let startTime = self.startTime else { return }
            
            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime >= Double(self.totalDuration) {
                self.stopBreathingExercise() // Automatically stop if total duration reached
                return
            }
            
            self.timeRemaining -= 1
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
