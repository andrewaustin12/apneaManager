//
//  PreBreatheDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct PreBreatheDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
                    Section {
                        
                        Text("Pre-breathing is a powerful technique but must be practiced with caution. It's recommended to do this under guidance, especially for beginners, and never while in water or in a situation where losing consciousness could be dangerous.")
                        
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
                        
                        Text("Choose a quiet and relaxed setting where you can sit or lie down without being disturbed. Ensure your body is in a comfortable and supported position."
                        )
                    } header: {
                        Text("Select a Comfortable Location")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        
                        Text("Pre-breathing is a technique used to optimize the oxygen and carbon dioxide levels in your body, often by controlled hyperventilation. It's important to do this carefully and within safe limits."
                        )
                    } header: {
                        Text("Understand Pre-Breathing")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Begin by taking a few normal breaths to establish a relaxed baseline.")
                        Text("Pay attention to your natural breathing rhythm.")
                        
                    } header: {
                        Text("Start with Normal Breathing")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Shift to deeper, slower breaths, inhaling fully and exhaling completely.")
                        Text("Focus on filling your lungs with each inhalation and emptying them completely with each exhalation.")
                        
                    } header: {
                        Text("Begin Controlled Breathing")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("After a minute or so, gradually increase the pace of your breathing.")
                        Text("This may involve taking more breaths per minute than normal, but avoid hyperventilating or feeling dizzy.")
                        
                    } header: {
                        Text("Gradually Increase Pace")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Continue this controlled, slightly faster breathing for a brief period, typically not more than a minute or two.")
                        Text("Stay mindful of any signs of discomfort or dizziness, and return to normal breathing if these occur.")
                        
                    } header: {
                        Text("Maintain for a Short Duration")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Gradually slow your breathing back to a normal pace.")
                        Text("Take a few deep, calming breaths before concluding the session.")
                        
                    } header: {
                        Text("Return to Normal Breathing")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("Sit quietly for a moment, allowing your body to settle and your breathing to normalize.")
                        Text("Reflect on the sensation and calmness achieved through the exercise.")
                        
                    } header: {
                        Text("Conclude and Reflect")
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
            .navigationTitle("Pre Breathe")
        }
    }
}

#Preview {
    PreBreatheDetailView()
}
