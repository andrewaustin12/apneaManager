////
////  TrainingTimerView.swift
////  ApneaManager
////
////  Created by andrew austin on 1/7/24.
////
//
//import SwiftUI
//import SwiftData
//
//
//struct TrainingBreatholdTimerView: View {
//    @Environment(\.modelContext) private var context
//
//    @State private var personalBestHold: Int = 0
//    
//    @State private var progress: CGFloat = 0
//    @State private var elapsedTime: CGFloat = 0
//    @State private var isActive = false
//    @State private var isNewPersonalBest: Bool = false
//    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
//    
//    
//    var body: some View {
//        VStack {
//            VStack {
//                Text("Current PB: \(personalBestHold)")
//                    .font(.title3)
//                    .bold()
//                BreathHoldHeader(secondsElapsed: Int(elapsedTime), theme: .buttercup, personalBestSeconds: personalBestHold)
//            }
//            .padding(.bottom)
//            Button(action: {
//                if isActive {
//                    isActive = false
//                    let elapsedInt = Int(elapsedTime)
//                    
//                    // Check if the current session is a new personal best
//                    isNewPersonalBest = elapsedInt > personalBestHold
//                    if isNewPersonalBest {
//                        personalBestHold = elapsedInt
//                        saveSession(duration: elapsedInt, isPersonalBest: true)
//                    } else {
//                        saveSession(duration: elapsedInt)
//                    }
//                    
//                    // Reset for the next session
//                    progress = 0
//                    elapsedTime = 0
//                } else {
//                    isActive = true
//                    isNewPersonalBest = false
//                }
//            }) {
//                Text(isActive ? "Stop" : "Start")
//                    .font(.title)
//                    .bold()
//            }
//            .buttonStyle(.borderedProminent)
//            
//            // Progress Circle
//            ZStack {
//                Circle()
//                    .stroke(lineWidth: 24)
//                    .opacity(0.3)
//                    .foregroundColor(Color.gray)
//                
//                CircleProgressShape(progress: progress)
//                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(Color.blue)
//                    .animation(.linear, value: progress)
//                
//                VStack {
//                    Text("Time")
//                        .font(.largeTitle)
//                    Text(timeString(from: elapsedTime))
//                        .font(.largeTitle)
//                        .bold()
//                }
//            }
//            .padding(.horizontal)
//            
//            
//            /// Create a model that pops up here
//            if isNewPersonalBest {
//                Text("New Personal Best: \(timeString(from: CGFloat(personalBestHold)))")
//                    .font(.headline)
//                    .padding()
//            }
//        }
//        .onReceive(timer) { _ in
//            guard isActive else { return }
//            updateProgress()
//        }
//        .navigationTitle("Breath Hold Test")
//    }
//    
//    private func updateProgress() {
//        elapsedTime += 0.05
//        progress = (elapsedTime.truncatingRemainder(dividingBy: 60)) / 60
//    }
//    
//    private func timeString(from totalSeconds: CGFloat) -> String {
//        let minutes = Int(totalSeconds) / 60
//        let seconds = Int(totalSeconds) % 60
//        return String(format: "%02d:%02d", minutes, seconds)
//    }
//    
//    private func saveSession(duration: Int, isPersonalBest: Bool = false) {
//        let personalBestSession = PersonalBestBreatholdSession(duration: duration, isPersonalBest: isPersonalBest)
//        let genericSession = Session(image: "freediver-3", title: "Breath Hold", subTitle: "Session type:", duration: Double(duration))
//
//        // Save sessions using SwiftData
//        context.insert(personalBestSession)
//        context.insert(genericSession)
//    }
//
//}
//
//
//
////struct PersonalBestView_Previews: PreviewProvider {
////    static var previews: some View {
////        // Create a sample session for preview
////        let sampleSession = PersonalBestBreatholdSession(duration: 120, date: Date(), isPersonalBest: true)
////        PersonalBestView(session: sampleSession)
////    }
////}
//
//
//#Preview {
//    NavigationStack {
//        TrainingBreatholdTimerView()
//    }
//}
//
//
//
//// Optional: Display all sessions
//// List(sessions, id: \.duration) { session in
////     Text("Session: \(timeString(from: CGFloat(session.duration))) \(session.isPersonalBest ? "(Personal Best)" : "")")
//// }
