//
//  ExerciseView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI

struct ExerciseView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                TraningCardView(image: "pranayama-1", title: "Anulom Vilom", subHeading: "Alternate Nostril Breathing", description: "Conscious breath regulation by inhaling through one nostril while keeping the other closed.")
                
                TraningCardView(image: "pranayama-1", title: "Kapalbhati", subHeading: "Skull Shining Breath", description: "describe here")
                
                TraningCardView(image: "pranayama-1", title: "Ujjayi", subHeading: "Ocean Breath", description: "describe here")
                
                TraningCardView(image: "pranayama-1", title: "Bhramari", subHeading: "Bee Breath", description: "describe here")
                
                TraningCardView(image: "pranayama-1", title: "Anulom Vilom", subHeading: "Alternate Nostril Breathing", description: "describe here")
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Exercise")
        }
        
    }
}

#Preview {
    ExerciseView()
}
