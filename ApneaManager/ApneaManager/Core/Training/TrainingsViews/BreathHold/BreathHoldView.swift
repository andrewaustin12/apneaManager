//
//  BreathHoldView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData

struct BreathHoldView: View {
    // Detail view state
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    // timer state
    @State private var progress: CGFloat = 0
    @State private var elapsedTime: CGFloat = 0
    @State private var isActive = false
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    // Model state
    @Environment(\.modelContext) private var context
    @Query var sessions: [Session]
    //@State var session: Session
    @State private var personalBestHold: Int = 0
    @State private var isNewPersonalBest: Bool = false
    @State private var duration: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
                    if let longestBreathHoldSession = Session.longestSessionByType(sessions: breathHoldSessions) {
                        BreathHoldHeader(secondsElapsed: Int(elapsedTime), personalBestSeconds: longestBreathHoldSession.duration)
                    }
                }
                .padding(.bottom)
                .onAppear {
                    updatePersonalBest()
                }
                
                Button(action: {
                    if isActive {
                        isActive = false
                        let elapsedInt = Int(elapsedTime)
                        
                        // Save the session and check for new personal best
                        saveSession(duration: elapsedInt)
                        
                        // Reset for the next session
                        progress = 0
                        elapsedTime = 0
                    } else {
                        isActive = true
                        isNewPersonalBest = false
                    }
                }) {
                    Text(isActive ? "Stop" : "Start")
                        .font(.title)
                        .bold()
                }
                .buttonStyle(.borderedProminent)
                
                // Progress Circle
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
                
                // Display new personal best message
                if isNewPersonalBest {
                    Text("New Personal Best: \(timeString(from: CGFloat(personalBestHold)))")
                        .font(.headline)
                        .padding()
                }
            }
            .onReceive(timer) { _ in
                guard isActive else { return }
                updateProgress()
            }
            .navigationTitle("Breath Hold Test")
            
            HStack {
                Spacer()
                Button("Guidance") {
                    showingDetail = true
                }
                .padding(.trailing)
                .padding(.bottom)
                .buttonStyle(.bordered)
            }
            
        }
        .sheet(isPresented: $showingDetail) {
            BreathHoldDetailView()
        }
    }
    
    private func updateProgress() {
        elapsedTime += 0.05
        progress = (elapsedTime.truncatingRemainder(dividingBy: 60)) / 60
    }
    
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        
        if minutes == 0 {
            // For durations less than a minute, display in seconds format (e.g., "7s")
            return "\(seconds)s"
        } else {
            // For durations a minute or longer, display in minute:second format (e.g., "1:01")
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
    private func updatePersonalBest() {
        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
        if let longestSession = breathHoldSessions.max(by: { $0.duration < $1.duration }) {
            personalBestHold = longestSession.duration
        }
    }
    
    
    private func saveSession(duration: Int) {
        let newSession = Session(
            //sessionID: UUID(),
            date: Date(),
            image: "freediver-3",
            sessionType : .breathHold,
            duration: Int(duration)
        )
        
        
        // Check if the current session is a new personal best
        if duration > personalBestHold {
            personalBestHold = duration
            isNewPersonalBest = true
            print("DEBUG: New personal best of \(personalBestHold) seconds acheived!")
        } else {
            isNewPersonalBest = false
        }
        
        
        // Save the session using SwiftData
        context.insert(newSession)
        print("DEBUG: New breath hold session added! Session length: \(newSession.duration)")
    }
}

#Preview {
    NavigationStack {
        BreathHoldView()
    }
}
