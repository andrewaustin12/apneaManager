//
//  CO2TrainingSettingsView.swift
//  ApneaManager
//
//  Created by andrew austin on 2/5/24.
//

import SwiftUI

struct CO2TrainingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var percentageOfPersonalBest: Double = 60
    @State var initialRestDuration: Int = 15
    @State var reductionPerRound: Int = 5
    @State var totalRounds: Int = 8
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Initial Breath Hold Duration")) {
                    Slider(value: $percentageOfPersonalBest, in: 20...80, step: 1) {
                        Text("Starting % of Personal Best")
                    } minimumValueLabel: {
                        Text("20%")
                    } maximumValueLabel: {
                        Text("80%")
                    }
                    Text("\(Int(percentageOfPersonalBest))% of Personal Best")
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Duration")) {
                    Stepper("\(initialRestDuration) sec", value: $initialRestDuration, in: 15...120, step: 5)
                    Text("Initial rest duration between holds in seconds.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Reduction")) {
                    Stepper("\(reductionPerRound) sec", value: $reductionPerRound, in: 1...10)
                    Text("Amount of rest reduced each round in seconds.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                }
                
                Section(header: Text("Training Rounds")) {
                    Picker("Total Rounds: \(totalRounds)", selection: $totalRounds) {
                        ForEach(1...20, id: \.self) { count in
                            Text("\(count) rounds")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 120) // Adjust the frame height to better accommodate the picker
                }
                
            }
            VStack {
                UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
            }
            
            .navigationTitle("CO2 Training Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// Example usage in a parent view or preview
struct CO2TrainingSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CO2TrainingSettingsView()
    }
}

