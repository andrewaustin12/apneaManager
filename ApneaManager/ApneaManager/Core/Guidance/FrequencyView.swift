//
//  FrequencyView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI

struct FrequencyView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("How often?") {
                    Text("Try doing dry apnea about 2 – 4 times per week.")
                }
            }
            .listSectionSpacing(1.0)
            .navigationTitle("Frequency of Training")
        }
    }
}

#Preview {
    FrequencyView()
}
