//
//  O2TablesInfoView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct O2TablesInfoView: View {

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
            
                    Section {
                        
                        Text("O2 table training in dry static apnea focuses on enhancing a freediver's oxygen management and breath-hold endurance by extending recovery times to reduce oxygen consumption during successive breath-holds.")
                    } header: {
                        Text("Purpose")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        
                        Text("An O2 table in freediving training consists of progressively longer rest intervals between breath-holds, designed to improve oxygen efficiency and extend the overall duration of breath-holding by reducing oxygen consumption.")
                    } header: {
                        Text("Essence of the table")
                            .font(.headline)
                            .bold()
                    }

                    Section {
                        DisclosureGroup("Improved Oxygen Efficiency") {
                            Text("Training with O2 tables helps in optimizing the body's usage of oxygen, allowing for longer breath-holds by improving the efficiency of oxygen consumption.")
                        }
                        DisclosureGroup("Increased Breath-Hold Duration") {
                            Text("By extending recovery times between breath-holds, the body is better able to replenish oxygen, gradually increasing the diver's overall breath-hold capacity.")
                        }
                        DisclosureGroup("Enhanced Mental Strength") {
                            Text("This training also cultivates mental endurance and calmness, essential for coping with the stress and discomfort of extended breath-holding.")
                        }
                        DisclosureGroup("Safer Adaptation to Long Breath-Holds") {
                            Text("Practicing in a controlled, dry environment allows for a safer and more gradual adaptation to the physical and mental demands of extended breath-holds, reducing the risk of hypoxia (oxygen deprivation).")
                        }
                        
                    } header: {
                        Text("Benifits")
                            .font(.headline)
                            .bold()
                    }
                    
                }
                .listStyle(.plain)
            }
            .navigationTitle("O2 Tables")
        }
    }
}

#Preview {
    O2TablesInfoView()
}
