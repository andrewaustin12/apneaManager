import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Session.date) var sessions: [Session]
    @State private var isBreathHoldChartExpanded: Bool = false
    @State private var isOverallSessionsChartExpanded: Bool = false
    
    @State private var selectedFilter: SessionFilter = .all

    enum SessionFilter: String, CaseIterable, Identifiable {
        case all = "All Sessions"
        case breathHold = "Breath Hold"
        case prebreathe = "Pre Breathe"
        case O2Table = "O2 Table"
        case Co2Table = "Co2 Table"
        case squareBreath = "Square Breath"
        case pranayama = "Pranayama"
        var id: String { self.rawValue }
    }
    
    enum SortOrder {
        case newestFirst, oldestFirst
    }
    
    @State private var sortOrder: SortOrder = .newestFirst
    
    var filteredAndSortedSessions: [Session] {
        let filteredSessions: [Session] = {
            switch selectedFilter {
            case .all:
                return sessions
            case .breathHold:
                return sessions.filter { $0.sessionType == .breathHold }
            case .prebreathe:
                return sessions.filter { $0.sessionType == .prebreathe }
            case .O2Table:
                return sessions.filter { $0.sessionType == .O2Table }
            case .Co2Table:
                return sessions.filter { $0.sessionType == .Co2Table }
            case .squareBreath:
                return sessions.filter { $0.sessionType == .squareBreath }
            case .pranayama:
                return sessions.filter { $0.sessionType == .pranayama }
            }
        }()
        
        return filteredSessions.sorted {
            sortOrder == .newestFirst ? $0.date > $1.date : $0.date < $1.date
        }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                upgradeCardSection
                
                chartSection(title: "Breath Hold Test Progress Chart", isExpanded: $isBreathHoldChartExpanded) {
                    if sessions.filter({ $0.sessionType == .breathHold }).count > 1 {
                        HistoryChartView(sessions: sessions.filter { $0.sessionType == .breathHold })
                    } else {
                        Text("Two or more breath hold tests are needed to show charts")
                            .padding()
                    }
                }
                
                chartSection(title: "Overall Sessions Chart", isExpanded: $isOverallSessionsChartExpanded) {
                    HistorySessionsChartView(sessions: sessions)
                }
                
                filterAndSortingPicker
                
                sessionCountView(filteredSessions: filteredAndSortedSessions)
                
                sessionList(filteredSessions: filteredAndSortedSessions)
            }
        }
        .navigationTitle("History")
    }

    @ViewBuilder
    private var upgradeCardSection: some View {
        UpgradeCardView(image: "freediver-3", title: "Upgrade to Pro", buttonLabel: "Learn More")
    }
    
    @ViewBuilder
    private func chartSection<Content: View>(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: { isExpanded.wrappedValue.toggle() }) {
                    Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                }
            }
            .padding([.horizontal])
            
            if isExpanded.wrappedValue {
                content()
            }
        }
        .padding(.bottom, 5)
    }
    
    @ViewBuilder
    private var filterAndSortingPicker: some View {
        HStack {
            Menu {
                ForEach(SessionFilter.allCases, id: \.self) { filter in
                    Button(action: { selectedFilter = filter }) {
                        Text(filter.rawValue)
                    }
                }
            } label: {
                HStack {
                    Text(selectedFilter.rawValue)
                    Image(systemName: "line.horizontal.3.decrease.circle")
                }
                .padding(.vertical, 5)
                .padding(.horizontal)
                .foregroundColor(.white)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                .shadow(radius: 2)
            }

            Spacer()
            
            Picker("Sort Order", selection: $sortOrder) {
                Text("Newest First").tag(SortOrder.newestFirst)
                Text("Oldest First").tag(SortOrder.oldestFirst)
            }
            .pickerStyle(.segmented)
            .labelsHidden()
        }
        .padding(.horizontal)
        .padding(.vertical, 5)
    }
    
    @ViewBuilder
    private func sessionCountView(filteredSessions: [Session]) -> some View {
        HStack {
            Text("Total Training sessions: ")
            Spacer()
            Text("\(filteredSessions.count)")
        }
        .font(.headline)
        .padding()
    }
    
    @ViewBuilder
    private func sessionList(filteredSessions: [Session]) -> some View {
        ForEach(filteredSessions) { session in
            VStack {
                TrainingHistoryCardView(image: session.image, title: session.sessionType.rawValue, date: session.date, duration: Double(session.duration))
                    .padding(.horizontal)
                    .padding(.bottom, 2)

                Divider()
                    .padding(.horizontal)
                    .padding(.bottom, 10)
            }
        }
    }
}
