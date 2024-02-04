//
//  PreBreatheView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct PreBreatheView: View {
    @Environment(\.modelContext) private var context
    @State private var showingDetail = false
    @State private var showingSettingsSheet = false
    @State private var detailViewType: String = ""
    @State private var totalDuration: Int = 2 * 60
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pre Breathe")
                    .font(.largeTitle)
                    .bold()
            }
            
            
            PrebreatheTimer(totalDuration: $totalDuration)
                .padding()
            
            // HStack for buttons
            HStack {
                Button("Settings") {
                    showingSettingsSheet = true
                }
                .padding()
                .buttonStyle(.bordered)
                
                Spacer()
                
                Button("Guidance") {
                    showingDetail = true
                }
                .padding()
                .buttonStyle(.bordered)
            }
            
        }
        .sheet(isPresented: $showingDetail) {
            PreBreatheDetailView()
        }
        .sheet(isPresented: $showingSettingsSheet) {
            PreBreatheSettingsDetailView(totalDuration: $totalDuration)
        }
    }
    
    
}

#Preview {
    NavigationStack {
        PreBreatheView()
    }
}


