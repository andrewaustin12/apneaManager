//
//  O2TrainingSettings.swift
//  ApneaManager
//
//  Created by andrew austin on 2/5/24.
//

import SwiftUI

struct O2TrainingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var percentageOfPersonalBest: Double
    @Binding var restDuration: Int
    @Binding var totalRounds: Int

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Initial Breath Hold Percentage")) {
                    Slider(value: $percentageOfPersonalBest, in: 20...80, step: 1) {
                        Text("Starting % of Personal Best")
                    } minimumValueLabel: {
                        Text("20%")
                    } maximumValueLabel: {
                        Text("80%")
                    }
                    Text("\(Int(percentageOfPersonalBest))% of Personal Best")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Duration")) {
                    Stepper("Initial Rest Duration: \(restDuration) sec", value: $restDuration, in: 30...240, step: 5)
                        .padding(.vertical)
                    Text("Amount of rest between each round")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Training Rounds")) {
                    Picker("Total Rounds: \(totalRounds)", selection: $totalRounds) {
                        ForEach(2...30, id: \.self) { count in
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
            
            .navigationTitle("O2 Training Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    O2TrainingSettingsView(percentageOfPersonalBest: .constant(40),
                           restDuration: .constant(120),
                           totalRounds: .constant(8))
}
