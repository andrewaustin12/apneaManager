//
//  PranayamaBreathInfoView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/10/24.
//

import SwiftUI

struct PranayamaBreathInfoView: View {

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
            
                    Section {
                        Text("Pranayama Alternate Nostril Breathing, a traditional yoga technique, involves alternating the breath through each nostril to balance the body and mind, and enhance mental, physical, and emotional wellbeing.")
                    } header: {
                        Text("Purpose")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        Text("The essence of this technique is in its ability to balance the left and right hemispheres of the brain, achieved through the alternating rhythm of breathing which calms and centers the mind.")
                    } header: {
                        Text("Essence of the Technique")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        DisclosureGroup("Balanced Energy Flow") {
                            Text("This technique helps in balancing the flow of energy in the body, harmonizing the left and right sides, associated with logical and creative thinking.")
                        }
                        DisclosureGroup("Reduced Stress and Anxiety") {
                            Text("By promoting a sense of calm and relaxation, it effectively reduces stress and anxiety levels.")
                        }
                        DisclosureGroup("Improved Lung Function and Respiratory Endurance") {
                            Text("Regular practice strengthens the respiratory system, improving lung function and endurance.")
                        }
                        DisclosureGroup("Enhanced Concentration and Mental Clarity") {
                            Text("It aids in enhancing concentration, mental clarity, and focus, making it beneficial for meditation and mindfulness practices.")
                        }
                        
                    } header: {
                        Text("Benefits")
                            .font(.headline)
                            .bold()
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("Pranayama Breathing")
        }
    }
}


#Preview {
    PranayamaBreathInfoView()
}
