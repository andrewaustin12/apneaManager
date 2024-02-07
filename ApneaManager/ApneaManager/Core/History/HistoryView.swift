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
    @State private var isChartExpanded: Bool = true
    
    
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
    
    // Filtered sessions for breathhold only
    var breathholdSessions: [Session] {
        sortedSessionHistorys.filter { $0.sessionType == .breathHold }
    }
    
    
    var body: some View {
        NavigationStack{
            VStack {
                VStack {
                    /// IF pro user this does not display
                    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
                }
                
                HStack {
                    Text("Breath Hold Test Progress Chart")
                        .font(.headline)
                    Spacer()
                    Button(action: { isChartExpanded.toggle() }) {
                        Image(systemName: isChartExpanded ? "chevron.up" : "chevron.down")
                    }
                }
                .padding()
                
                // Collapsible Chart View
                if isChartExpanded && breathholdSessions.count > 1 {
                    HistoryChartView(sessions: breathholdSessions)
                } else if !isChartExpanded {
                    // Optionally show a compact representation or nothing
                } else {
                    ContentUnavailableView(label: {
                        Label("Not Enough Data", systemImage: "chart.xyaxis.line")
                    }, description: {
                        Text("Two or more breath hold tests are needed to show charts")
                            .padding()
                    })
                }
                
                Picker("Sort Order", selection: $sortOrder) {
                    Text("Newest First").tag(SortOrder.newestFirst)
                    Text("Oldest First").tag(SortOrder.oldestFirst)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                .padding(.leading)
                .padding(.trailing)
                
                
                HStack {
                    Text("Total Training sessions: ")
                    Spacer()
                    Text("\(sessions.count)")
                }
                .font(.headline)
                .padding(.leading)
                .padding(.trailing)
                
                
                List {
                    if sortedSessionHistorys.count >= 1 {
                        ForEach(sortedSessionHistorys, id: \.self) { session in
                            
                            TrainingHistoryCardView(image: session.image, title: session.sessionType.rawValue, date: session.date, duration: Double(session.duration))
                                .foregroundStyle(Color.primary)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(sortedSessionHistorys[index])
                            }
                        }
                    } else {
                        ContentUnavailableView(label: {
                            Label("No Training Session", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Complete your first session to see your most recent trainings")
                                .padding()
                        })
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
