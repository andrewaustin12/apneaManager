//
//  Prebreathe.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct PrebreatheTimer: View {
    @State private var progress: CGFloat = 0
    @State private var elapsedTime: CGFloat = 0
    @State private var isActive = false
    @State private var showAlert = false  // New state variable for showing the alert
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    let maxTime: CGFloat = 120 // Two minutes in seconds

    var body: some View {
        VStack {
            Button(action: {
                if isActive {
                    isActive = false
                    progress = 0
                    elapsedTime = 0
                } else {
                    isActive = true
                    showAlert = false  // Reset alert when starting
                }
            }) {
                Text(isActive ? "Stop" : "Start")
                    .font(.title)
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 24)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                CircleProgressShape(progress: progress)
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: progress)
                
                VStack {
                    Text("Time")
                        .font(.largeTitle)
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
        .alert(isPresented: $showAlert) {  // Alert view
            Alert(
                title: Text("Timer Complete"),
                message: Text("Your pre-breath is complete."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func updateProgress() {
        if elapsedTime < maxTime {
            elapsedTime += 0.05
            progress = elapsedTime / maxTime
        } else {
            isActive = false // Stop the timer
            showAlert = true  // Show the alert
        }
    }
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}



#Preview {
    PrebreatheTimer()
}
