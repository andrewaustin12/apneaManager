//
//  SquareBreathingDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct SquareBreathingDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
                    Section {

                        Text("Choose a quiet, comfortable place where you can sit or lie down without interruptions. Ensure your posture is relaxed."
                        )
                    } header: {
                        Text("Find a Comfortable Spot")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        
                        Text("Square breathing involves four equal parts: inhaling, holding your breath, exhaling, and holding again. Each part is done for the same duration, typically 4 seconds."
                        )
                    } header: {
                        Text("Understand the Pattern")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        Text("Take a moment to clear your mind of distractions.")
                        Text("Focus your attention on your breathing.")

                    } header: {
                        Text("Begin with a Clear Mind")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Inhale for 4 seconds, slowly and deeply, filling your lungs with air.")
                        Text("Hold your breath for 4 seconds, keeping a relaxed posture.")
                        Text("Exhale gently for 4 seconds, releasing all the air from your lungs.")
                        Text("Hold again for 4 seconds before the next inhalation.")
                    } header: {
                        Text("Start the Breathing Cycle")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("Continue this pattern for several minutes. Aim for a relaxed, rhythmic flow, keeping each part of the square even and smooth.")

                    } header: {
                        Text("Repeat the Cycle")
                            .font(.headline)
                            .bold()
                        
                    }
                    Section {
                        Text("After completing your cycles, allow your breathing to return to its natural rhythm, and take a moment to reflect on the calmness you've achieved")

                    } header: {
                        Text("Conclude with Normal Breathing")
                            .font(.headline)
                            .bold()
                        
                    }
                    
                    Section {
                        Text("Square breathing is a simple yet powerful technique to promote relaxation and mental clarity, making it suitable for stress relief and mindfulness practices.")
                    } header: {
                        Text("Mindfulness")
                            .font(.headline)
                            .bold()
                    }
                    
                }
                .listStyle(.automatic)
                .toolbar{
                    Button("Dismiss") {
                                presentationMode.wrappedValue.dismiss()
                            }
                            .position(x: 16, y: 16)
                }
                
            }
            .navigationTitle("Guidance")
        }
    }
}

#Preview {
    SquareBreathingDetailView()
}
