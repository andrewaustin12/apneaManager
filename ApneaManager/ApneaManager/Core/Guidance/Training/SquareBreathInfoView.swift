//
//  SquareBreathInfoView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/10/24.
//

import SwiftUI

struct SquareBreathInfoView: View {

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
            
                    Section {
                        Text("Square breathing, a simple relaxation technique, involves inhaling, holding, exhaling, and holding again for equal durations, typically four seconds each, to promote mental calmness and focus.")
                    } header: {
                        Text("Purpose")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("The essence of square breathing lies in its symmetrical pattern where each phase of breathing is equal in duration, creating a 'square' of breaths that aids in stress relief and mindfulness.")
                    } header: {
                        Text("Essence of the Technique")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        DisclosureGroup("Stress Reduction") {
                            Text("By maintaining a rhythmic and controlled breathing pattern, square breathing helps in reducing stress and anxiety levels.")
                        }
                        DisclosureGroup("Improved Focus and Concentration") {
                            Text("This breathing technique aids in enhancing focus and concentration by calming the mind and reducing distractions.")
                        }
                        DisclosureGroup("Enhanced Lung Function") {
                            Text("Regular practice of square breathing can improve lung function and breathing efficiency over time.")
                        }
                        DisclosureGroup("Promotes Relaxation") {
                            Text("The equal intervals of breathing in square breathing promote relaxation and can be a useful tool for meditation and mindfulness practices.")
                        }
                        
                    } header: {
                        Text("Benefits")
                            .font(.headline)
                            .bold()
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Square Breathing")
        }
    }
}

#Preview {
    SquareBreathInfoView()
}
