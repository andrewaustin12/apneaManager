//
//  PreBreatheView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct PreBreatheView: View {
    @State private var showingDetail = false
    @State private var detailViewType: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Pre Breathe")
                    .font(.largeTitle)
                    .bold()
            }
            
            
            PrebreatheTimer()
                .padding()
            
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
            PreBreatheDetailView()
        }
    }
}

#Preview {
    NavigationStack {
        PreBreatheView()
    }
}
