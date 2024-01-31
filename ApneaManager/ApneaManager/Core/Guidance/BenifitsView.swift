//
//  BenifitsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI

struct BenifitsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Improved Lung Capacity and Efficiency") {
                    Text("Regular training can increase lung volume and improve the efficiency of oxygen usage in the body.")
                }
                Section("Enhanced Diaphragm Strength") {
                    Text("It strengthens the diaphragm and other respiratory muscles, leading to better breathing control.")
                }
                Section("Increased CO2 Tolerance") {
                    Text("It enhances the body's tolerance to carbon dioxide, which can improve endurance in various sports and activities.")
                }
                Section("Improved Focus and Mental Discipline") {
                    Text("Holding your breath requires concentration and mental discipline, skills that can be beneficial in many aspects of life.")
                }
                Section("Stress Reduction") {
                    Text("Like meditation, static apnea can induce a state of relaxation and mental calmness, reducing stress levels")
                }
            }
            .listSectionSpacing(1.0)
            .navigationTitle("Benifits to static apnea")
        }
    }
}

#Preview {
    NavigationStack {
        BenifitsView()
    }
}
