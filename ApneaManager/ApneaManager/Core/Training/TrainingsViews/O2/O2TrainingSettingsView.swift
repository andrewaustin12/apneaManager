

/// Normal view disabled

import SwiftUI
import RevenueCat
import RevenueCatUI

struct O2TrainingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @Binding var percentageOfPersonalBest: Double
    @Binding var restDuration: Int
    @Binding var totalRounds: Int
    @State private var isProUser: Bool = false
    @State private var showingProAlert: Bool = false


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
                    .disabled(!subscriptionManager.isProUser)
                    Text("\(Int(percentageOfPersonalBest))% of Personal Best")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Duration")) {
                    Stepper("Initial Rest Duration: \(restDuration) sec", value: $restDuration, in: 30...240, step: 5)
                        .disabled(!subscriptionManager.isProUser)
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
                    .disabled(!subscriptionManager.isProUser)
                }

            }
            .navigationTitle("O2 Training Settings")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
//            .onAppear {
//                checkProStatus()
//            }
            if !subscriptionManager.isProUser {
                VStack {
                    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Unlock")
                }
            }
        }
    }
    
//    private func checkProStatus() {
//        // Check the subscription status with RevenueCat
//        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
//            if let purchaserInfo = purchaserInfo {
//                // Assuming "Pro" is your entitlement identifier on RevenueCat change Pro to No to test 
//                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
//            } else if let error = error {
//                print("Error fetching purchaser info: \(error)")
//            }
//        }
//    }
}

#Preview {
    O2TrainingSettingsView(percentageOfPersonalBest: .constant(40),
                           restDuration: .constant(120),
                           totalRounds: .constant(8))
}

/// Overlay version

//import SwiftUI
//import RevenueCat
//import RevenueCatUI
//
//struct O2TrainingSettingsView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Binding var percentageOfPersonalBest: Double
//    @Binding var restDuration: Int
//    @Binding var totalRounds: Int
//    @State private var isProUser: Bool = false
//    @State private var isShowingPaywall = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                List {
//                    Section(header: Text("Initial Breath Hold Percentage")) {
//                        Slider(value: $percentageOfPersonalBest, in: 20...80, step: 1) {
//                            Text("Starting % of Personal Best")
//                        } minimumValueLabel: {
//                            Text("20%")
//                        } maximumValueLabel: {
//                            Text("80%")
//                        }
//                        Text("\(Int(percentageOfPersonalBest))% of Personal Best")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    Section(header: Text("Rest Duration")) {
//                        Stepper("Initial Rest Duration: \(restDuration) sec", value: $restDuration, in: 30...240, step: 5)
//                            .padding(.vertical)
//                        Text("Amount of rest between each round")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    Section(header: Text("Training Rounds")) {
//                        Picker("Total Rounds: \(totalRounds)", selection: $totalRounds) {
//                            ForEach(2...30, id: \.self) { count in
//                                Text("\(count) rounds")
//                            }
//                        }
//                        .pickerStyle(WheelPickerStyle())
//                        .frame(height: 120) // Adjust the frame height to better accommodate the picker
//                    }
//
//                }
//                .blur(radius: isProUser ? 0 : 3) // Optionally blur the content if not a pro user
//
//                if !isProUser {
//                    VStack {
//                        Text("Pro Features")
//                            .font(.title)
//                            .bold()
//                            .padding()
//                        Text("This feature is available for Pro users only.")
//                            .padding(.bottom)
//                        Button("Learn More") {
//                            isShowingPaywall = true
//                        }
//                        .padding()
//                        .bold()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .background(Color.black.opacity(0.3)) // Semi-transparent overlay
//                }
//            }
//            .navigationTitle("O2 Training Settings")
//            .navigationBarItems(trailing: Button("Done") {
//                presentationMode.wrappedValue.dismiss()
//            })
//            .onAppear {
//                checkProStatus()
//            }
//            .sheet(isPresented: $isShowingPaywall, content: {
//                PaywallView()
//            })
//        }
//    }
//
//    private func checkProStatus() {
//        // Example code to check the subscription status with RevenueCat
//        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
//            if let purchaserInfo = purchaserInfo {
//                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
//            } else if let error = error {
//                print("Error fetching purchaser info: \(error)")
//            }
//        }
//    }
//}
//
//// Example Preview Provider (assuming you have default values for bindings)
//struct O2TrainingSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        O2TrainingSettingsView(percentageOfPersonalBest: .constant(40),
//                               restDuration: .constant(120),
//                               totalRounds: .constant(8))
//    }
//}

