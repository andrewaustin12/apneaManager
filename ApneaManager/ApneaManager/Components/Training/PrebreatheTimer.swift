//
//  Prebreathe.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct PrebreatheTimer: View {
    @Environment(\.modelContext) private var context
        @State private var progress: CGFloat = 0
        @State private var elapsedTime: CGFloat = 0
        @State private var isActive = false
        @State private var showAlert = false  // New state variable for showing the alert
        let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
        
        @Binding var totalDuration: Int  // Binding to pass in the total duration
        
        let maxTime: CGFloat  // Use the total duration as the max time

        init(totalDuration: Binding<Int>) {
            self._totalDuration = totalDuration
            self.maxTime = CGFloat(totalDuration.wrappedValue)
        }

    var body: some View {
        VStack {
            Button(action: {
                if isActive {
                    isActive = false
                    let elapsedInt = Int(elapsedTime)
                    
                    // Save the session and check for new prebreathe
                    saveSession(duration: elapsedInt)
                    
                    // Reset for the next session
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
            isActive = false
            showAlert = true
            saveSession(duration: Int(elapsedTime))
        }
    }
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    private func saveSession(duration: Int) {
        let newSession = Session(
            //sessionID: UUID(),
            date: Date(),
            image: "freediver-2",
            sessionType : .prebreathe,
            duration: Int(duration)
            )

        // Save the session using SwiftData
        context.insert(newSession)
        print("DEBUG: New pre breathe session added! Session length: \(newSession.duration)")
    }
}



#Preview {
    PrebreatheTimer(totalDuration: .constant(120))
}
