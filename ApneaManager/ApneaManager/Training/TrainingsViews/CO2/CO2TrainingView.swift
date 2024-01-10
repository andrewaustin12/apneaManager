//
//  CO2TrainingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct CO2TrainingView: View {
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TrainingHeaderView(secondsElapsed: 6, secondsRemaining: 12, theme: .buttercup)
                
                TrainingBreatholdTimerView()
                
                HStack {
                    Spacer()
                    Button("Guidance") {
                        showingDetail = true
                    }
                    .padding(.trailing)
                    .padding(.bottom)
                    .buttonStyle(.bordered)
                }
            }
            .navigationTitle("CO2 Table Training")
            .sheet(isPresented: $showingDetail) {
                CO2TrainingDetailView()
            }
            
        }
    }
}

#Preview {
    CO2TrainingView()
}
