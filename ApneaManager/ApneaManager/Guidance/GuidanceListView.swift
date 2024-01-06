//
//  GuidanceListView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI

struct GuidanceListView: View {

    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {

                List {
                    NavigationLink {
                        GuidanceView()
                    } label: {
                        listRowGuidanceView()
                    }
                    NavigationLink {
                        BenifitsView()
                    } label: {
                        listRowBenefitsView()
                    }
                    NavigationLink {
                        FrequencyView()
                    } label: {
                        listRowFrequencyView()
                    }
                    
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Guidance")
    }
}


#Preview {
    NavigationStack {
        GuidanceListView()
    }
}

extension GuidanceListView {
    
    private func listRowGuidanceView() -> some View {
        HStack {
            
            Image("flatMan")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading) {
                Text("Dry static apnea training")
                    .font(.headline)
                Text("A how to guide")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private func listRowBenefitsView() -> some View {
        HStack {
            
            Image("trophy")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading) {
                Text("Benefits of dry static apnea training")
                    .font(.headline)
                Text("Why you should ")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private func listRowFrequencyView() -> some View {
        HStack {
            
            Image("calendar")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading) {
                Text("How often should you train?")
                    .font(.headline)
                Text("Frequency of training")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

}
