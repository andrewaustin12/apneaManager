//
//  PranayamaBreathingView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct PranayamaBreathingView: View {
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {

                
                TrainingTimerView()
                
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
            .navigationTitle("Pranayama Training")
            .sheet(isPresented: $showingDetail) {
                PranayamaBreathingDetailView()
            }
            
        }
    }
}

#Preview {
    PranayamaBreathingView()
}
