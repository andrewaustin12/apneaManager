//
//  BreathHoldView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct BreathHoldView: View {
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    
    var body: some View {
        NavigationStack {
            VStack{
                
                VStack {
                    Text("Breath Hold Test")
                        .font(.title)
                        .bold()
                }
                
                /// IF there is a curren Breath Hold PB show below ELSE show breathhold test
                VStack {
                    Text("Current PB: ")
                        .font(.title3)
                        .bold()
                    BreathHoldHeader(secondsElapsed: 65, theme: .buttercup, personalBestSeconds: 89)
                }
                .padding()
                
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
            .sheet(isPresented: $showingDetail) {
                BreathHoldDetailView()
            }
        }
        
    }
}
#Preview {
    BreathHoldView()
}
