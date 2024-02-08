import SwiftUI
import Charts

struct HistorySessionsChartView: View {
    var sessions: [Session]
    
    @State private var sortOrder: SortOrder = .alphabetically
    
    @Environment(\.colorScheme) var colorScheme
    
    enum SortOrder {
        case alphabetically, byCount
    }

    private var sessionCounts: [(type: String, count: Int)] {
        let grouped = Dictionary(grouping: sessions, by: { $0.sessionType.rawValue })
        let counts = grouped.map { (type: $0.key, count: $0.value.count) }.map { sessionCount in
            // Format the session type to display in two lines if it contains two words
            (type: formatSessionType(sessionCount.type), count: sessionCount.count)
        }
        
        switch sortOrder {
        case .alphabetically:
            return counts.sorted(by: { $0.type < $1.type })
        case .byCount:
            return counts.sorted(by: { $0.count > $1.count })
        }
    }
    
    var body: some View {
        VStack {
            Picker("Sort Order", selection: $sortOrder) {
                Text("Alphabetically").tag(SortOrder.alphabetically)
                Text("By Count").tag(SortOrder.byCount)
            }
            .pickerStyle(.segmented)
            .padding()

            Chart {
                ForEach(sessionCounts, id: \.type) { sessionCount in
                    BarMark(
                        x: .value("Session Type", sessionCount.type),
                        y: .value("Total", sessionCount.count)
                    )
                }
            }
            .chartXAxis {
                AxisMarks(preset: .aligned, position: .bottom)
            }
            .chartYAxis {
                AxisMarks(preset: .aligned, position: .leading)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 5)
        .padding(.horizontal)
        .shadow(color: colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1), radius: 2, x: 0, y: 1)
    }
    
    private func formatSessionType(_ text: String) -> String {
        // Split the text into words and insert a newline character between the first two words
        let words = text.split(separator: " ")
        guard words.count > 1 else { return text }
        return words[0...1].joined(separator: "\n")
    }
}

//// Example Usage
//struct HistorySessionsChartView_Previews: PreviewProvider {
//    static var previews: some View {
//        HistorySessionsChartView(sessions: [
//            Session(sessionType: .typeA, date: Date()),
//            Session(sessionType: .typeB, date: Date())
//            // Add more sessions as needed
//        ])
//    }
//}
