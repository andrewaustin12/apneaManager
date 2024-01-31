//
//  SquareBreathingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

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
    
    let phases = ["Inhale", "Hold", "Exhale", "Hold"]
    let colors = [Color.blue, Color.green, Color.red, Color.yellow]
    
    var body: some View {
        NavigationStack {
            VStack {
                
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
        resetTimer()
        currentPhaseIndex = 0
        moveToNextPhase()
    }
    
    func stopBreathingExercise() {
        timer?.invalidate()
        timer = nil
        phase = "Ready"

        // Calculate the total duration of the session
        let duration = (currentPhaseIndex - 1) * phaseDuration
        saveSession(duration: duration)
    }

    
    private func resetTimer() {
        timer?.invalidate()
        timeRemaining = phaseDuration
    }
    
    private func moveToNextPhase() {
        phase = phases[currentPhaseIndex % phases.count]
        resetTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                currentPhaseIndex += 1
                moveToNextPhase()
            }
        }
    }
    
    private func saveSession(duration: Int) {
        let newSession = Session(
            date: Date(),
            image: "freediver-4",
            sessionType: .squareBreath,
            duration: duration
        )
        
        // Save the session using SwiftData
        context.insert(newSession)
        print("DEBUG: New square breathing session added! Session length: \(newSession.duration)")
    }
}

#Preview {
    SquareBreathingView()
}
