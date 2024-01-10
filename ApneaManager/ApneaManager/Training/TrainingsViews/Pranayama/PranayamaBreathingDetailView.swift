//
//  PranayamaBreathingDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct PranayamaBreathingDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
                    Section {

                        Text("Sit in a comfortable position with a straight spine. You can sit on the floor with a cushion or on a chair."
                        )
                    } header: {
                        Text("Find a Comfortable Spot")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        
                        Text("Use your right hand. Curl your index and middle fingers into your palm, leaving your thumb, ring finger, and little finger extended."
                        )
                    } header: {
                        Text("Prepare Your Hand")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        Text("Close your eyes and take a few deep, natural breaths to relax.")
                        Text("Bring your focus to your breathing.")

                    } header: {
                        Text("Start with a Clear Mind")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Close Right Nostril: \nUse your right thumb to gently close your right nostril.")
                        Text("Inhale Left: \nInhale deeply through your left nostril.")
                        Text("Close Left Nostril: \nUse your ring finger to gently close your left nostril, releasing the right nostril.")
                        Text("Exhale Right: \nExhale fully through your right nostril.")
                        Text("Inhale Right: \nInhale deeply through your right nostril.")
                        Text("Close Right Nostril: \nUse your thumb to close the right nostril.")
                        Text("Exhale Left: \nExhale fully through your left nostril.")
                    } header: {
                        Text("Start the Breathing Cycle")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("Continue this alternating pattern for several minutes. Focus on smooth, even breaths without straining.")

                    } header: {
                        Text("Maintain the Flow")
                            .font(.headline)
                            .bold()
                        
                    }
                    Section {
                        Text("After completing the cycles, remove your hand and breathe deeply through both nostrils.")

                    } header: {
                        Text("Finish with Deep Breaths")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("Take a moment to sit quietly, observing the effects of the practice on your mind and body.")

                    } header: {
                        Text("Reflect and Relax")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Pranayama: Alternate Nostril Breathing is excellent for balancing the mind and body, enhancing concentration, and promoting relaxation. It's important to keep your breathing gentle and not forceful.")
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
            .navigationTitle("Pranayama Guidance")
        }
    }
}


#Preview {
    PranayamaBreathingDetailView()
}
