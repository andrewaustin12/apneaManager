//
//  CO2TablesP&B.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct CO2TablesInfoView: View {

    var body: some View {
        NavigationStack {
            
            VStack(alignment: .leading) {
                List {
            
                    Section {
    
                        
                        Text("CO2 tables in dry static apnea training for freediving are structured to progressively increase breath-hold times with fixed rest intervals, enhancing the diver's tolerance to carbon dioxide buildup. ")
                    } header: {
                        Text("Purpose")
                            .font(.headline)
                            .bold()
                    }
                    
                    Section {
                        
                        Text("A CO2 table in dry static apnea training is a systematic regimen that gradually extends breath-hold times with consistent rest intervals, enhancing tolerance to carbon dioxide buildup for improved freediving endurance.")
                    } header: {
                        Text("Essence of the table")
                            .font(.headline)
                            .bold()
                    }
                    ///MARK - try to add bullet list style here
                    Section {
                        DisclosureGroup("Increasing CO2 Tolerance") {
                            Text("As the body consumes oxygen and produces CO2 during breath-holding, the urge to breathe is mainly triggered by rising CO2 levels, not by the lack of oxygen. By practicing breath-holds with increasing retention times and consistent rest intervals, CO2 tables help train the body to tolerate higher levels of CO2.")
                        }
                        DisclosureGroup("Improving Breath-Hold Duration") {
                            Text("Regular training with CO2 tables can lead to increased breath-hold times. This is because the body becomes more efficient at managing CO2 buildup, which is often the limiting factor in how long one can hold their breath.")
                        }
                        DisclosureGroup("Enhancing Mental Fortitude") {
                            Text("Breath-holding is as much a mental challenge as a physical one. Training with CO2 tables helps in developing the mental strength and focus needed for long breath-holds, as it accustoms the diver to the discomfort of high CO2 levels.")
                        }
                        DisclosureGroup("Safety and Adaptation") {
                            Text("Training on dry land (as opposed to in water) is safer and more controlled. It allows freedivers to gradually adapt their bodies to the sensations and challenges of breath-holding without the risks associated with being underwater.")
                        }
                        DisclosureGroup("Monitoring Progress") {
                            Text("By following a structured regimen like CO2 tables, freedivers can systematically track their progress. This helps in setting realistic goals and understanding personal limits.")
                        }
                        
                    } header: {
                        Text("Benifits")
                            .font(.headline)
                            .bold()
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("CO2 Tables")
        }
    }
}
#Preview {
    CO2TablesInfoView()
}
