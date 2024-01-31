//
//  PreBreatheSettingsDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/31/24.
//

import SwiftUI

struct PreBreatheSettingsDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var totalDuration: Int
    
    var body: some View {
        NavigationStack {
            
            List {
                
                HStack {
                    Picker("Total Duration", selection: $totalDuration) {
                        ForEach(1...30, id: \.self) { duration in // Adjust the range as needed
                            Text("\(duration) min").tag(duration * 60) // Convert minutes to seconds
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            }
            VStack {
                UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
            }
            .navigationTitle("Settings")
            .toolbar{
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .position(x: 16, y: 16)
            }
        }
    }
}

#Preview {
    PreBreatheSettingsDetailView(totalDuration: .constant(120))
}
