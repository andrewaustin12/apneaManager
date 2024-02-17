/// NO overlay view

import SwiftUI
import RevenueCat

struct CO2TrainingSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @Binding var percentageOfPersonalBest: Double
    @Binding var initialRestDuration: Int
    @Binding var reductionPerRound: Int
    @Binding var totalRounds: Int
    
    @State private var isProUser: Bool = false
    
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
                    }.disabled(!subscriptionManager.isProUser)
                    Text("\(Int(percentageOfPersonalBest))% of Personal Best")
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Duration")) {
                    Stepper("\(initialRestDuration) sec", value: $initialRestDuration, in: 1...120, step: 1)
                        .disabled(!subscriptionManager.isProUser)
                    Text("Initial rest duration between holds in seconds.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Section(header: Text("Rest Reduction")) {
                    Stepper("\(reductionPerRound) sec", value: $reductionPerRound, in: 1...10)
                        .disabled(!subscriptionManager.isProUser)
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
                    .frame(height: 100) // Adjust the frame height to better accommodate the picker
                    .disabled(!subscriptionManager.isProUser)
                }
                
            }
            
            .navigationTitle("CO2 Training Settings")
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
//        // Example code to check the subscription status with RevenueCat
//        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
//            if let purchaserInfo = purchaserInfo {
//                // Assuming "pro_access" is your entitlement identifier on RevenueCat
//                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
//            } else if let error = error {
//                print("Error fetching purchaser info: \(error)")
//            }
//        }
//    }
}

// Example usage in a parent view or preview
struct CO2TrainingSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        CO2TrainingSettingsView(percentageOfPersonalBest: .constant(60),
                                initialRestDuration: .constant(15),
                                reductionPerRound: .constant(5),
                                totalRounds: .constant(8))
    }
}


//import SwiftUI
//import RevenueCat
//
//struct CO2TrainingSettingsView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @Environment(\.colorScheme) var colorScheme // Detect current color scheme
//    @Binding var percentageOfPersonalBest: Double
//    @Binding var initialRestDuration: Int
//    @Binding var reductionPerRound: Int
//    @Binding var totalRounds: Int
//    
//    @State private var isProUser: Bool = false
//    @State private var isShowingPaywall = false
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                List {
//                    Section(header: Text("Initial Breath Hold Duration")) {
//                        Slider(value: $percentageOfPersonalBest, in: 20...80, step: 1) {
//                            Text("Starting % of Personal Best")
//                        } minimumValueLabel: {
//                            Text("20%")
//                        } maximumValueLabel: {
//                            Text("80%")
//                        }
//                        Text("\(Int(percentageOfPersonalBest))% of Personal Best")
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    Section(header: Text("Rest Duration")) {
//                        Stepper("\(initialRestDuration) sec", value: $initialRestDuration, in: 1...120, step: 1)
//                        Text("Initial rest duration between holds in seconds.")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    
//                    Section(header: Text("Rest Reduction")) {
//                        Stepper("\(reductionPerRound) sec", value: $reductionPerRound, in: 1...10)
//                        Text("Amount of rest reduced each round in seconds.")
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                        
//                    }
//                    
//                    Section(header: Text("Training Rounds")) {
//                        Picker("Total Rounds: \(totalRounds)", selection: $totalRounds) {
//                            ForEach(1...20, id: \.self) { count in
//                                Text("\(count) rounds")
//                            }
//                        }
//                        .pickerStyle(WheelPickerStyle())
//                        .frame(height: 120)
//                    }
//                }
//                .blur(radius: isProUser ? 0 : 3)
//
//                if !isProUser {
//                    overlayView
//                }
//            }
//            .navigationTitle("CO2 Training Settings")
//            .navigationBarItems(trailing: Button("Done") {
//                presentationMode.wrappedValue.dismiss()
//            })
//            .onAppear {
//                checkProStatus()
//            }
//            .sheet(isPresented: $isShowingPaywall, content: {
//                // PaywallView() or any other view you want to present
//            })
//        }
//    }
//    
//    private var overlayView: some View {
//        VStack {
//            Spacer()
//            UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
//            Spacer()
//            Spacer()
////            Text("Pro Features")
////                .font(.title)
////                .bold()
////                .padding()
////            Text("This feature is available for Pro users only.")
////                .padding(.bottom)
////            Button("Learn More") {
////                isShowingPaywall = true
////            }
////            .padding()
////            .background(Color.blue)
////            .foregroundColor(.white)
////            .clipShape(RoundedRectangle(cornerRadius: 10))
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(overlayBackground) // Dynamic background based on color scheme
//    }
//    
//    // Dynamic background based on the current color scheme
//    private var overlayBackground: Color {
//        colorScheme == .light ? Color.black.opacity(0.15) : Color.black.opacity(0.3)
//    }
//
//    private func checkProStatus() {
//        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
//            if let purchaserInfo = purchaserInfo {
//                // Check if the user is a pro user based on the "Pro" entitlement
//                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
//            } else if let error = error {
//                print("Error fetching purchaser info: \(error)")
//            }
//        }
//    }
//}
//
//// Example usage in a parent view or preview
//struct CO2TrainingSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        CO2TrainingSettingsView(percentageOfPersonalBest: .constant(60),
//                                initialRestDuration: .constant(15),
//                                reductionPerRound: .constant(5),
//                                totalRounds: .constant(8))
//    }
//}
