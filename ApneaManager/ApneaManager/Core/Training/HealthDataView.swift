////
////  HealthDataView.swift
////  ApneaManager
////
////  Created by andrew austin on 2/7/24.
////
//
//import SwiftUI
//
//struct HealthDataView: View {
//    @State private var heartRate: Double?
//    @State private var spo2: Double?
//    @State private var errorMessage: String?
//
//    var body: some View {
//        VStack {
//            if let heartRate = heartRate {
//                Text("Heart Rate: \(heartRate, specifier: "%.2f") bpm")
//            }
//            if let spo2 = spo2 {
//                Text("SpO2: \(spo2, specifier: "%.2f")%")
//            }
//            if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)").foregroundColor(.red)
//            }
//        }
//        .onAppear {
//            requestHealthData()
//        }
//    }
//
//    private func requestHealthData() {
//        let healthKitManager = HealthKitManager()
//        
//        healthKitManager.requestAuthorization { success, error in
//            if success {
//                healthKitManager.fetchLatestHeartRate { rate, error in
//                    if let rate = rate {
//                        self.heartRate = Double(rate)
//                    } else if let error = error {
//                        self.errorMessage = error.localizedDescription
//                    }
//                }
//                
//                healthKitManager.fetchLatestSpO2 { spo2Value, error in
//                    if let spo2Value = spo2Value {
//                        self.spo2 = spo2Value
//                    } else if let error = error {
//                        self.errorMessage = error.localizedDescription
//                    }
//                }
//            } else {
//                self.errorMessage = error?.localizedDescription ?? "Authorization failed."
//            }
//        }
//    }
//}
