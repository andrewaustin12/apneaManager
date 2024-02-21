//
//  SquareBreathingSettingsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/31/24.
//

import SwiftUI

struct SquareBreathingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
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
                        ForEach(1...30, id: \.self) { duration in // Adjust the range as needed
                            Text("\(duration) min").tag(duration * 60) // Convert minutes to seconds
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .position(x: 16, y: 16)
            }
            if !subscriptionManager.isProUser {
                VStack {
                    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SquareBreathingSettingsView(phaseDuration: .constant(4), totalDuration: .constant(300))
    }

}
