//
//  HistoryView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData


struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Session.date) var sessions: [Session]
    
    
    /// sorting session history
    @State private var sortOrder: SortOrder = .newestFirst
    enum SortOrder {
        case newestFirst, oldestFirst
    }
    
    var sortedSessionHistorys: [Session] {
        switch sortOrder {
        case .newestFirst:
            return sessions.sorted { $0.date > $1.date }
        case .oldestFirst:
            return sessions.sorted { $0.date < $1.date }
        }
    }
    
    
    
    var body: some View {
        NavigationStack{
            VStack {
                UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
                Picker("Sort Order", selection: $sortOrder) {
                    Text("Newest First").tag(SortOrder.newestFirst)
                    Text("Oldest First").tag(SortOrder.oldestFirst)
                }
                .pickerStyle(.segmented)
                .padding()
                
                HStack {
                    Text("Total Training sessions: \(sessions.count)")
                    Spacer()
                }
                .padding(.leading)
                
                
                List {
                    ForEach(sortedSessionHistorys, id: \.self) { session in
                        
                        TrainingHistoryCardView(image: session.image, title: session.sessionType.rawValue, date: session.date, duration: Double(session.duration))
                            .foregroundStyle(Color.primary)                        
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(sortedSessionHistorys[index])
                        }
                    }
                    /// IF user is PRO open full history view
                    /// ELSE show just card list
                }
                .listStyle(.plain)
            }
            
            .scrollIndicators(.hidden)
            
            
            
        }
        .navigationTitle("History")
    }
    
}


#Preview {
    HistoryView()
}
