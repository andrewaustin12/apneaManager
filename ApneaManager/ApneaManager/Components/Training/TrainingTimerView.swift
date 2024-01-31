////
////  TrainingTimerView.swift
////  ApneaManager
////
////  Created by andrew austin on 1/9/24.
////
//
//import SwiftUI
//
//struct TrainingTimerView: View {
//    @State private var progress: CGFloat = 0
//    @State private var elapsedTime: CGFloat = 0
//    @State private var isActive = false
//    @State private var personalBestHold: Int = 0
//    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        VStack {
//            Button(action: {
//                if isActive {
//                    isActive = false
//                    if Int(elapsedTime) > personalBestHold {
//                        personalBestHold = Int(elapsedTime)
//                    }
//                    progress = 0
//                    elapsedTime = 0
//                } else {
//                    isActive = true
//                }
//            }) {
//                Text(isActive ? "Stop" : "Start")
//                    .font(.title)
//                    .bold()
//            }
//            .buttonStyle(.borderedProminent)
//
//            ZStack {
//                Circle()
//                    .stroke(lineWidth: 24)
//                    .opacity(0.3)
//                    .foregroundColor(Color.gray)
//
//                CircleProgressShape(progress: progress)
//                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
//                    .foregroundColor(Color.blue) /// Set user theme here
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
//        }
//        .onReceive(timer) { _ in
//            guard isActive else { return }
//            updateProgress()
//        }
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
//}
//
//
//
//#Preview {
//    TrainingTimerView()
//}
