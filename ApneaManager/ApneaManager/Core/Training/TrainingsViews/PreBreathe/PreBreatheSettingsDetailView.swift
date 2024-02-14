//
//  PreBreatheSettingsDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/31/24.
//

import SwiftUI
import RevenueCat

struct PreBreatheSettingsDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var totalDuration: Int
    
    @State private var isProUser: Bool = false
    
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
                    .disabled(!isProUser)
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .position(x: 16, y: 16)
            }
            .onAppear {
                checkProStatus()
            }
            if !isProUser {
                VStack {
                    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Unlock")
                }
            }
        }
    }
    private func checkProStatus() {
        // Example code to check the subscription status with RevenueCat
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            if let purchaserInfo = purchaserInfo {
                // Assuming "pro_access" is your entitlement identifier on RevenueCat
                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
            } else if let error = error {
                print("Error fetching purchaser info: \(error)")
            }
        }
    }
}

#Preview {
    PreBreatheSettingsDetailView(totalDuration: .constant(120))
}
