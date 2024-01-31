//
//  CO2TrainingDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct CO2TrainingDetailView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
                    Section {
                        
                            Text("This preparation right before beginning ensures you're mentally and physically ready to start your CO2 table session effectively and safely.")
                        
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

                        Text("Ensure your timer is set with the pre-planned CO2 table intervals."
                        )
                    } header: {
                        Text("Check your timer")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Sit or lie down in your chosen comfortable position.")
                        Text("Ensure you're relaxed, with no physical tension.")
                    } header: {
                        Text("Final Positioning")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        Text("Perform a few calm, deep breaths to oxygenate your body.")
                        Text("Focus on steady inhalation and exhalation to establish a rhythm.")
                        
                    } header: {
                        Text("Final Breathing Exercise:")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("Clear your mind of distractions.")
                        Text("Focus on the task at hand, visualizing successful completion of each breath-hold.")

                    } header: {
                        Text("Mental Focus")
                            .font(.headline)
                            .bold()
                    }
                    Section {
                        Text("Quickly remind yourself of the signs to stop (e.g., extreme discomfort or dizziness) and remember to always listen to your body.")

                    } header: {
                        Text("Safety Reminder")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("With one last deep breath, prepare to start the first breath-hold as soon as the timer begins.")
                        Text("Stay focused and calm as you enter the first hold.")

                    } header: {
                        Text("Start the first cycle")
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
            .navigationTitle("C02 Table Guidance")
        }
    }
}

#Preview {
    CO2TrainingDetailView()
}
