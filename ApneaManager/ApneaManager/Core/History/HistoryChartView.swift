//
//  HistoryChartView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI
import Charts



struct HistoryChartView: View {
    var sessions: [Session]
    @State private var selectedTimeScale: TimeScale = .total

    private var filteredSessions: [Session] {
        let calendar = Calendar.current
        let now = Date()
        
        switch selectedTimeScale {
        case .total:
            return sessions
        case .year:
            return sessions.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .year)
            }
        case .month:
            return sessions.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .month)
            }
        case .day:
            return sessions.filter {
                calendar.isDate($0.date, equalTo: now, toGranularity: .day)
            }
        }
    }

    var body: some View {
        VStack {
            
            Picker("Time Scale", selection: $selectedTimeScale) {
                ForEach(TimeScale.allCases) { scale in
                    Text(scale.rawValue).tag(scale)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if filteredSessions.count > 1 {
                Chart(filteredSessions) { session in
                    AreaMark(
                        x: .value("Date", session.date),
                        y: .value("Duration", session.duration)
                    )
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
                }
                .chartXAxis {
                    AxisMarks(preset: .aligned, position: .bottom)
                }
                .frame(height: 200)
                .padding()
            } else {
                ContentUnavailableView(label: {
                    Label("Not Enough Data", systemImage: "chart.xyaxis.line")
                }, description: {
                    Text("Two or more breath hold tests are needed to show charts")
                        .padding()
                })
            }
        }
    }
}

enum TimeScale: String, CaseIterable, Identifiable {
    case total = "Total", year = "Year", month = "Month", day = "Day"
    
    var id: String { self.rawValue }
}


// Example Preview
//struct HistoryChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Define your sessions here
//        let exampleSessions = [
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 30), image: "freediver-1", sessionType: .breathHold, duration: 60),
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 25), image: "freediver-1", sessionType: .breathHold, duration: 80),
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 20), image: "freediver-1", sessionType: .breathHold, duration: 100),
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 15), image: "freediver-1", sessionType: .breathHold, duration: 120),
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 10), image: "freediver-1", sessionType: .breathHold, duration: 140),
//            Session(id: UUID(), date: Date().addingTimeInterval(-86400 * 5), image: "freediver-1", sessionType: .breathHold, duration: 160)
//        ]
//        
//        HistoryChartView(sessions: exampleSessions)
//    }
//}




//struct HistoryChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        // Generate sample data
//        let sampleSessions = (1...10).map { day -> Session in
//            // Create a date 'day' days ago, a random duration for the breathhold, and include image and sessionType
//            let date = Calendar.current.date(byAdding: .day, value: -day, to: Date())!
//            let duration = Int.random(in: 30...180) // Example duration between 30 to 180 seconds
//            return Session(id: UUID(), date: date, image: "freediver-1", sessionType: .breathHold, duration: duration)
//        }
//        
//        HistoryChartView(sessions: sampleSessions)
//            .modelContainer(for: Session.self)
//    }
//}


