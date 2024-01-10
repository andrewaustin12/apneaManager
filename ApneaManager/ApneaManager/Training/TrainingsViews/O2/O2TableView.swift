//
//  O2TableView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct O2TableView: View {
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TrainingHeaderView(secondsElapsed: 2, secondsRemaining: 8, theme: .bubblegum )
                
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
            .navigationTitle("O2 Table Training")
            .sheet(isPresented: $showingDetail) {
                O2TrainingDetailView()
            }
            
        }
    }
}

#Preview {
    O2TableView()
}
