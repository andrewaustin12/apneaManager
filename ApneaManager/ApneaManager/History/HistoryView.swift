//
//  HistoryView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI



struct HistoryView: View {
    
    
    
    let history = [
        SessionHistory(id: UUID(), image: "freediver-1", title: "CO2 Training", subTitle: "Session type:", date: "26 May", time: "2:42", duration: 124),
        SessionHistory(id: UUID(), image: "freediver-3", title: "Breath Hold", subTitle: "Session type:", date: "26 May", time: "1:56", duration: 243),
        SessionHistory(id: UUID() ,image: "freediver-2", title: "O2 Training", subTitle: "Session type:", date: "26 May", time: "12:15", duration: 125),
        SessionHistory(id: UUID() ,image: "freediver-4", title: "Square Table", subTitle: "Session type:", date: "26 May", time: "12:15", duration: 121),
        SessionHistory(id: UUID() ,image: "freediver-2", title: "O2 Training", subTitle: "Session type:", date: "27 May", time: "22:25", duration: 222),
        SessionHistory(id: UUID() ,image: "pranayama-1", title: "Pranayama Breath", subTitle: "Session type:", date: "29 May", time: "15:12", duration: 421),
        SessionHistory(id: UUID() ,image: "freediver-4", title: "Square Table", subTitle: "Session type:", date: "26 May", time: "11:55", duration: 542),
        SessionHistory(id: UUID() ,image: "freediver-1", title: "CO2 Training", subTitle: "Session type:", date: "26 May", time: "12:15", duration: 212),
        SessionHistory(id: UUID() ,image: "freediver-1", title: "CO2 Training", subTitle: "Session type:", date: "26 May", time: "13:55", duration: 423),
        SessionHistory(id: UUID() ,image: "freediver-1", title: "CO2 Training", subTitle: "Session type:", date: "26 May", time: "15:25", duration: 422),
            
        ]
    
    var body: some View {
        NavigationStack{
            VStack {
                UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
                ScrollView {
                    ForEach(history, id: \.self) { item in
                        TrainingHistoryCardView(image: item.image, title: item.title, subTitle: item.subTitle, date: item.date, time: item.time)
                        /// IF user is PRO open full history view
                        /// ELSE show just card list
                    }
                }
                .scrollIndicators(.hidden)
                .padding(8)
                
                
            }
            .navigationTitle("History")
        }
        
    }
}

#Preview {
    HistoryView()
}
