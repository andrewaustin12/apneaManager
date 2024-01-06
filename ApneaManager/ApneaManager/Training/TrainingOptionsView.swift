//
//  TrainingOptionsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/5/24.
//

import SwiftUI

struct TrainingOptionsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        TraningCardView(
                            image: "freediver-1",
                            title: "CO2 Training",
                            subHeading: "16 CYCLES | TIME - 11:32",
                            description: "CO2 table is a series of breath hold sessions that give you less time to recover between them."
                        )
                        TraningCardView(
                            image: "freediver-2",
                            title: "O2 Training",
                            subHeading: "8 CYCLES | TIME - 22:32",
                            description: "CO2 table is a series of breath hold sessions that give you less time to recover between them."
                        )
                        
                        TraningCardView(
                            image: "freediver-3",
                            title: "Breath Hold Test",
                            subHeading: "Test Your Hold",
                            description: "Start here to set your tables based on your best breath hold time."
                        )
                        
                        TraningCardView(
                            image: "freediver-4",
                            title: "Square Table",
                            subHeading: "10 Cycles - 4 in 4 out",
                            description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                        )
                        
                        TraningCardView(
                            image: "pranayama-1",
                            title: "Pranayama Breath",
                            subHeading: "10 Cycles - 4 in 4 out",
                            description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                        )
                        
                    }
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Sessions:")
                    TrainingTimeCardView(image: "trophy", title: "Personal Best", subTitle: "BREATH HOLD", time: "3:42")
                    TrainingTimeCardView(image: "freediver-1", title: "Last Session", subTitle: "CO2 TABLE", time: "2:42")
                    TrainingTimeCardView(image: "freediver-2", title: "Last Session", subTitle: "O2 TABLE", time: "3:42")
                    TrainingTimeCardView(image: "freediver-3", title: "Last Session", subTitle: "BREATH HOLD Test", time: "3:42")
                    TrainingTimeCardView(image: "freediver-4", title: "Last Session", subTitle: "SQUARE BREATHING", time: "13:42")
                    TrainingTimeCardView(image: "pranayama-1", title: "Last Session", subTitle: "PRANAYAMA BREATHING", time: "20:42")
                }
                .padding()
                .scrollIndicators(.never)
                
                Spacer()
            }
            .navigationTitle("Training")
        }
        
    }
}

#Preview {
    TrainingOptionsView()
}
