//
//  BreathHoldDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct BreathHoldDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
                    Section {
                        
                            Text("Remember, while aiming for a personal best, it's crucial to stay attuned to your body's signals and prioritize safety over pushing for a record.")
                        
                    } header: {
                       
                        Label {
                            Text("Saftey and Consideration")
                                .font(.headline)
                        } icon: {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundStyle(.yellow)
                        }
                    }
                    Section {

                        Text("Choose a comfortable, quiet location where you can fully focus."
                        )
                        Text("Engage in relaxation techniques to calm your mind and body. Deep, steady breathing can help achieve a relaxed state.")
                    } header: {
                        Text("Mental / Physical Preparation")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Perform a series of deep, controlled breaths to oxygenate your body.")
                        Text("Include some deep inhales and full exhales to prepare your lungs for the extended hold.")
                    } header: {
                        Text("Optimal Breathing Warm-Up")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        Text("Have a clear target time in mind, but also be prepared to listen to your body and not push beyond safe limits.")
                        
                    } header: {
                        Text("Set Your Goal")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Ensure someone is aware of your activity, especially if you're alone.")
                        Text("Be aware of the signs that indicate you need to stop, like extreme discomfort or dizziness.")

                    } header: {
                        Text("Safety First")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("In the moments before your attempt, clear your mind of distractions.")
                        Text("Visualize successfully reaching your goal, focusing on the sensation of holding your breath for that duration.")

                    } header: {
                        Text("Final Focus and Visualization")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Take a deep, full breath and begin your hold when you feel at your most relaxed and ready.")
                        Text("Maintain a calm, focused mindset throughout the hold.")

                    } header: {
                        Text("Commence the Attempt")
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
            .navigationTitle("Breath Hold Guidance")
        }
    }
}

#Preview {
    BreathHoldDetailView()
}
