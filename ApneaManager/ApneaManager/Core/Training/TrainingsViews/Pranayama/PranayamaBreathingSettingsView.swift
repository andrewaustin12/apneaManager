//
//  PranayamaSettingsView.swift
//  ApneaManager
//
//  Created by andrew austin on 2/2/24.
//

import SwiftUI


struct PranayamaBreathingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var phaseDuration: Int
    @Binding var totalDuration: Int

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Picker("Phase Duration", selection: $phaseDuration) {
                        ForEach(1...30, id: \.self) { duration in
                            Text("\(duration) sec").tag(duration)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }

                HStack {
                    Picker("Total Duration", selection: $totalDuration) {
                        ForEach(1...30, id: \.self) { duration in
                            Text("\(duration) min").tag(duration * 60)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            VStack {
                UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
            }
            .navigationBarTitle("Settings", displayMode: .large)
            .toolbar {
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}





//struct PranayamaBreathingSettingsView_Previews: PreviewProvider {
//    // Creating mock bindings for the preview
//    @State static var mockPhaseDuration: Double = 30
//    @State static var mockTotalDuration: Double = 300
//
//    static var previews: some View {
//        // Use the NavigationStack if your settings view relies on it for navigation appearance
//        NavigationStack {
//            // Providing mock bindings to the PranayamaBreathingSettingsView
//            PranayamaBreathingSettingsView(phaseDuration: $mockPhaseDuration, totalDuration: $mockTotalDuration)
//        }
//    }
//}
