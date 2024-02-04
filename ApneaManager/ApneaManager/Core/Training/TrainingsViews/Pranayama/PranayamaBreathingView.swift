////
////  PranayamaBreathingView.swift
////  ApneaManager
////
////  Created by andrew austin on 1/7/24.
////
//
//import SwiftUI
//
//struct PranayamaBreathingView: View {
//    // Model state
//    @Environment(\.modelContext) private var context
//    
//    @State private var showingDetail = false
//    @State private var showingSettingsSheet = false
//    @State private var detailViewType: String = ""
//    
//    @State private var phase: String = "Ready"
//    @State private var timeRemaining: Int = 0
//    @State private var timer: Timer?
//    @State private var phaseDuration: Int = 4 // Duration for each phase in seconds
//    @State private var totalDuration: Int = 5 * 60 // Default total duration is 5 minutes
//    @State private var currentPhaseIndex = 0
//    
//    let phases = [
//        "Inhale through Left Nostril",
//        "Exhale through Right Nostril",
//        "Inhale through Right Nostril",
//        "Exhale through Left Nostril"
//    ]
//    let colors = [Color.blue, Color.green, Color.red, Color.yellow]
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                
//                VStack {
//                    
//                    
//                    Spacer()
//                    
//                    ZStack {
//                        Circle()
//                            .stroke(lineWidth: 20)
//                            .opacity(0.3)
//                            .foregroundColor(colors[currentPhaseIndex % colors.count])
//
//                        VStack(spacing: 10) { // Use a VStack with spacing to separate elements vertically.
//                            Text(phase)
//                                .font(.system(size: 34, weight: .bold)) // Adjusted for better fit.
//                                .foregroundColor(colors[currentPhaseIndex % colors.count])
//                                .multilineTextAlignment(.center)
//                                .padding(.horizontal) // Add horizontal padding to avoid edge clipping.
//
//                            Text("\(timeRemaining)s")
//                                .font(.system(size: 40))
//                                .padding(.top, 10) // Increased padding to push this further down from the phase text.
//                        }
//                    }
//                    .frame(width: 320, height: 320)
//                    .padding()
//
//                    
//                    HStack {
//                        Button(action: startBreathingExercise) {
//                            Text("Start")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.green)
//                                .cornerRadius(8)
//                        }
//                        
//                        Button(action: stopBreathingExercise) {
//                            Text("Stop")
//                                .foregroundColor(.white)
//                                .padding()
//                                .background(Color.red)
//                                .cornerRadius(8)
//                        }
//                    }
//                    
//                    
//                    Spacer()
//                }
//                
//                
//                
//                // HStack for buttons
//                HStack {
//                    Button("Settings") {
//                        showingSettingsSheet = true
//                    }
//                    .padding()
//                    .buttonStyle(.bordered)
//                    
//                    Spacer()
//                    
//                    Button("Guidance") {
//                        showingDetail = true
//                    }
//                    .padding()
//                    .buttonStyle(.bordered)
//                }
//            }
//            .navigationTitle("Pranayama Training")
//            .sheet(isPresented: $showingDetail) {
//                PranayamaBreathingDetailView()
//            }
//            .sheet(isPresented: $showingSettingsSheet, content: {
//               PranayamaBreathingSettingsView(phaseDuration: $phaseDuration, totalDuration: $totalDuration)
//            })
//            
//        }
//    }
//    
//    func startBreathingExercise() {
//        resetTimer()
//        currentPhaseIndex = 0
//        moveToNextPhase()
//    }
//    
//    func stopBreathingExercise() {
//        timer?.invalidate()
//        timer = nil
//        phase = "Ready"
//
//        // Calculate the total duration of the session
//        let duration = (currentPhaseIndex - 1) * phaseDuration
//        saveSession(duration: duration)
//    }
//
//    
//    private func resetTimer() {
//        timer?.invalidate()
//        timeRemaining = phaseDuration
//    }
//    
//    private func moveToNextPhase() {
//        phase = phases[currentPhaseIndex % phases.count]
//        resetTimer()
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
//            if timeRemaining > 0 {
//                timeRemaining -= 1
//            } else {
//                currentPhaseIndex += 1
//                moveToNextPhase()
//            }
//        }
//    }
//    
//    private func saveSession(duration: Int) {
//        let newSession = Session(
//            date: Date(),
//            image: "pranayama-1",
//            sessionType: .pranayama,
//            duration: duration
//        )
//        
//        // Save the session using SwiftData
//        context.insert(newSession)
//        print("DEBUG: New Pranayama breathing session added! Session length: \(newSession.duration)")
//    }
//}
//
////struct PranayamaBreathingView: View {
////    @Environment(\.modelContext) private var context
////    @State private var showingDetail = false
////    @State private var showingSettingsSheet = false
////    @State private var phaseDuration: Int = 5 // Default phase duration is 5 seconds
////    @State private var totalDuration: Int = 5 * 60 // Default total duration is 5 minutes
////
////    var body: some View {
////        NavigationStack {
////            VStack {
////                Spacer()
////                TrainingTimerView(phaseDuration: Double(phaseDuration), totalDuration: Double(totalDuration))
////                Spacer()
////                
////                HStack {
////                    Button("Settings") {
////                        showingSettingsSheet = true
////                    }
////                    .padding()
////                    .buttonStyle(.bordered)
////                    
////                    Spacer()
////                    
////                    Button("Guidance") {
////                        showingDetail = true
////                    }
////                    .padding()
////                    .buttonStyle(.bordered)
////                }
////            }
////            .navigationTitle("Pranayama Training")
////            .sheet(isPresented: $showingSettingsSheet) {
////                PranayamaBreathingSettingsView(phaseDuration: $phaseDuration, totalDuration: $totalDuration)
////            }
////        }
////    }
////}
//
//
//#Preview {
//    PranayamaBreathingView()
//        .modelContainer(for: Session.self)
//}
//
//
//
////struct TrainingTimerView: View {
////    @Environment(\.modelContext) private var context
////        var phaseDuration: Double
////        @State private var elapsedTime = 0.0 // Track elapsed time in seconds
////        @State private var timeRemaining: Int
////        var totalDuration: Double // Total duration of the session
////        @State private var currentPhase = BreathingPhase.inhaleLeft
////        @State private var timerRunning = false
////        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
////
////        init(phaseDuration: Double, totalDuration: Double) {
////            self.phaseDuration = phaseDuration
////            self._timeRemaining = State(initialValue: Int(phaseDuration))
////            self.totalDuration = totalDuration
////        }
////    
////    var body: some View {
////        VStack(spacing: 20) {
////            Text(currentPhase.description)
////                .font(.title)
////                .padding()
////            
////            Text("\(timeRemaining) seconds")
////                .font(.largeTitle)
////                .padding()
////            
////            HStack(spacing: 20) {
////                Button(timerRunning ? "Pause" : "Start") {
////                    timerRunning.toggle()
////                    
////                    
////                }
////                .padding()
////                .background(timerRunning ? Color.yellow : Color.green)
////                .foregroundColor(.white)
////                .clipShape(Capsule())
////                
////                Button("Stop") {
////                    timerRunning = false
////                    saveSession()
////                    resetTimer()
////                }
////                .padding()
////                .background(Color.red)
////                .foregroundColor(.white)
////                .clipShape(Capsule())
////                
////                Button("Reset") {
////                    resetTimer()
////                }
////                .padding()
////                .background(Color.blue)
////                .foregroundColor(.white)
////                .clipShape(Capsule())
////            }
////        }
////        .onReceive(timer) { _ in
////            guard timerRunning else { return }
////            
////            elapsedTime += 1
////            if elapsedTime >= totalDuration {
////                timerRunning = false
////                saveSession() // Save when the session automatically completes
////            } else if timeRemaining > 0 {
////                timeRemaining -= 1
////            } else {
////                switchToNextPhase()
////            }
////        }
////    }
////    
////    func switchToNextPhase() {
////        currentPhase = currentPhase.next
////        timeRemaining = Int(phaseDuration)
////    }
////    
////    func resetTimer() {
////        currentPhase = .inhaleLeft
////        timeRemaining = Int(phaseDuration)
////        timerRunning = false
////    }
////    
////    enum BreathingPhase: String, CaseIterable {
////        case inhaleLeft = "Inhale through Left Nostril"
////        case exhaleRight = "Exhale through Right Nostril"
////        case inhaleRight = "Inhale through Right Nostril"
////        case exhaleLeft = "Exhale through Left Nostril"
////        
////        var next: BreathingPhase {
////            switch self {
////            case .inhaleLeft: return .exhaleRight
////            case .exhaleRight: return .inhaleRight
////            case .inhaleRight: return .exhaleLeft
////            case .exhaleLeft: return .inhaleLeft
////            }
////        }
////        
////        var description: String {
////            self.rawValue
////        }
////    }
////    
////    private func saveSession() {
////        // Adjust to save based on the elapsed time
////        let newSession = Session(
////            date: Date(),
////            image: "pranayama-1",
////            sessionType: .pranayama,
////            duration: Int(elapsedTime) // Use elapsed time for duration
////        )
////        
////        context.insert(newSession)
////        print("Pranayama Session saved with duration: \(Int(elapsedTime)) seconds")
////    }
////    
////    private func stopSession() {
////        timerRunning = false
////        saveSession()
////        
////    }
////}
//
//
////struct TrainingTimerView_Previews: PreviewProvider {
////    static var previews: some View {
////        TrainingTimerView()
////    }
////}
