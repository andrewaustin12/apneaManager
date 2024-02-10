//
//  Prebreathe.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct PrebreatheTimer: View {
    @Environment(\.modelContext) private var context
    @Environment(\.selectedTheme) var theme: Theme
    @State private var progress: CGFloat = 0 // Start with progress empty
    @State private var elapsedTime: CGFloat = 0
    @State private var isActive = false
    @State private var showAlert = false
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    @Binding var totalDuration: Int
    
    var maxTime: CGFloat {
        CGFloat(totalDuration)
    }
    
    var body: some View {
        VStack {
            Button(action: toggleTimer) {
                Text(isActive ? "Stop" : "Start")
                    .font(.title)
                    .bold()
                    .padding()
                    .background(isActive ? Color.red : theme.mainColor)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.vertical)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 24)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 24, lineCap: .round, lineJoin: .round))
                    .foregroundColor(theme.mainColor)
                    .rotationEffect(Angle(degrees: 270)) // Start from the top
                    .animation(.linear, value: progress)
                
                VStack {
                    Text("Time Remaining")
                        .font(.largeTitle)
                        .bold()
                        
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
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Timer Complete"),
                message: Text("Your pre-breath session is complete."),
                dismissButton: .default(Text("OK"))
            )
        }
        .onAppear {
            self.elapsedTime = self.maxTime // Initialize elapsedTime with maxTime on appear
        }
        .onChange(of: totalDuration) { _ in
                    updateTimerSettings()
                }
    }
    
    private func updateTimerSettings() {
            if !isActive {
                // Reset the timer settings only if the timer is not currently active
                self.progress = 0 // Ensure progress starts empty
                self.elapsedTime = CGFloat(totalDuration) // Reset elapsedTime to the full duration
                // Implement any additional logic needed for the new total duration
            }
        }
    
    private func toggleTimer() {
        isActive.toggle()
        if isActive {
            // Only reset if timer starts
            self.elapsedTime = self.maxTime
        } else {
            // Save session upon stopping
            saveSession(duration: Int(maxTime - elapsedTime))
        }
    }
    
    private func updateProgress() {
        if elapsedTime > 0 {
            elapsedTime -= 0.05
            progress = elapsedTime / maxTime
        } else if isActive {
            // Timer completes
            isActive = false
            showAlert = true
            saveSession(duration: Int(maxTime - elapsedTime))
            elapsedTime = maxTime // Reset for next session, optional based on desired behavior
            progress = 1.0
        }
    }
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
            let seconds = Int(totalSeconds) % 60
            if minutes == 0 {
                // For times less than a minute, show ":ss"
                return String(format: ":%02d", seconds)
            } else if minutes < 10 {
                // For times with less than 10 minutes, show "m:ss"
                return "\(minutes):\(String(format: "%02d", seconds))"
            } else {
                // For times with 10 or more minutes, show "mm:ss"
                return String(format: "%d:%02d", minutes, seconds)
            }
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
