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
                    NavigationLink {
                        CO2TablesInfoView()
                    } label: {
                        listRowCO2TablesInfoView()
                    }
                    NavigationLink {
                        O2TablesInfoView()
                    } label: {
                        listRowO2TablesInfoView()
                    }
                    
                }
                .listStyle(.plain)
                
                VStack(alignment: .leading) {
                    Label {
                        Text("Saftey and Consideration")
                            .font(.headline)
                    } icon: {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundStyle(.yellow)
                    }
                    .padding(.bottom, 3)
                    VStack {
                        Text("Remember, static apnea should always be practiced safely, preferably under professional supervision, and never alone, especially in water, to avoid the risk of blackout and drowning.")
                    }
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Guidance")
        }
        
    }
}


#Preview {
    
        GuidanceListView()
    
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
    
    private func listRowCO2TablesInfoView() -> some View {
        HStack {
            
            Image("calendar")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading) {
                Text("CO2 Tables")
                    .font(.headline)
                Text("Purpose and Benifits")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    private func listRowO2TablesInfoView() -> some View {
        HStack {
            
            Image("calendar")
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
            VStack(alignment: .leading) {
                Text("O2 Tables")
                    .font(.headline)
                Text("Purpose and Benifits")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

}
