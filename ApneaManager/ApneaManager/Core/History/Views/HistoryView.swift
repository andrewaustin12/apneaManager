import SwiftUI
import SwiftData
import RevenueCat
import RevenueCatUI


struct HistoryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.selectedTheme) var theme: Theme
    @Query(sort: \Session.date) var sessions: [Session]
    @State private var isBreathHoldChartExpanded: Bool = true
    @State private var isOverallSessionsChartExpanded: Bool = true
    @State private var showingProAlert = false
    /// Default filter
    @State private var selectedFilter: SessionFilter = .all
    @State private var selectedSection: ViewSection = .sessionHistory
    
    /// Pro state
    @State private var isProUser: Bool = false
    
    /// Sessions Picker Options
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
    
    /// Session History Sort Order
    enum SortOrder {
        case newestFirst, oldestFirst
    }
    
    /// History View Sections
    enum ViewSection: String, CaseIterable, Identifiable {
        case sessionHistory = "Session History"
        case charts = "Charts"
        var id: String { self.rawValue }
    }
    
    @State private var sortOrder: SortOrder = .newestFirst
    
    /// filter for limiting to 5 session in history list
    var filteredAndSortedSessions: [Session] {
        // First, filter the sessions based on the selected filter.
        let filteredSessions = sessions.filter { session in
            switch selectedFilter {
            case .all:
                return true
            case .breathHold:
                return session.sessionType == .breathHold
            case .prebreathe:
                return session.sessionType == .prebreathe
            case .O2Table:
                return session.sessionType == .O2Table
            case .Co2Table:
                return session.sessionType == .Co2Table
            case .squareBreath:
                return session.sessionType == .squareBreath
            case .pranayama:
                return session.sessionType == .pranayama
            }
        }
        
        // Then, sort the filtered sessions based on the sortOrder.
        let sortedSessions = filteredSessions.sorted {
            sortOrder == .newestFirst ? $0.date > $1.date : $0.date < $1.date
        }
        
        // Finally, if the user is not a pro user, limit the array to the last 5 sessions.
        return isProUser ? sortedSessions : Array(sortedSessions.prefix(5))
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if !isProUser {
                    upgradeCardSection
                }
                Picker("Select View", selection: customPickerBinding) {
                    ForEach(ViewSection.allCases) { section in
                        Text(section.rawValue).tag(section)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedSection == .sessionHistory {
                    filterAndSortingPicker
                    
                    sessionCountView(filteredSessions: filteredAndSortedSessions)
                    List {
                        sessionList(filteredSessions: filteredAndSortedSessions)
                    }
                    .listStyle(.plain)
                } else {
                    ScrollView {
                        chartSection(title: "Breath Hold Test Progress Chart", isExpanded: $isBreathHoldChartExpanded) {
                            if sessions.filter({ $0.sessionType == .breathHold }).count > 1 {
                                HistoryBreathHoldChartView(sessions: sessions.filter { $0.sessionType == .breathHold })
                            } else {
                                Text("Two or more breath hold tests are needed to show charts")
                                    .padding()
                            }
                        }
                        
                        chartSection(title: "Overall Sessions Chart", isExpanded: $isOverallSessionsChartExpanded) {
                            HistorySessionsChartView(sessions: sessions)
                        }
                    }
                }
            }
        }
        .navigationTitle("History")
        .onAppear {
            checkProStatus()
        }
        .alert(isPresented: $showingProAlert) {
            Alert(
                title: Text("Pro Feature"),
                message: Text("This session type is available for Pro users only."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    /// Upgrade to pro card
    @ViewBuilder
    private var upgradeCardSection: some View {
        UpgradeCardView(image: "freediver-3", title: "Upgrade to Pro", buttonLabel: "Learn More")
    }
    
    /// Charts
    @ViewBuilder
    private func chartSection<Content: View>(title: String, isExpanded: Binding<Bool>, @ViewBuilder content: () -> Content) -> some View {
        VStack {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: { isExpanded.wrappedValue.toggle() }) {
                    Image(systemName: isExpanded.wrappedValue ? "chevron.up" : "chevron.down")
                        .foregroundStyle(.gray)
                }
            }
            .padding([.horizontal])
            
            if isExpanded.wrappedValue {
                content()
            }
        }
        .padding(.bottom, 5)
    }
    
    /// History session filter
    @ViewBuilder
    private var filterAndSortingPicker: some View {
        HStack {
            if isProUser {
                Menu {
                    ForEach(SessionFilter.allCases, id: \.self) { filter in
                        Button(filter.rawValue) {
                            selectedFilter = filter
                        }
                    }
                } label: {
                    filterLabel
                }
            } else {
                filterLabel
                    .onTapGesture {
                        // Optionally show an alert or disable interaction
                        showingProAlert = true
                    }
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
        .alert(isPresented: $showingProAlert) {
            Alert(
                title: Text("Pro Feature"),
                message: Text("Filtering sessions by type is available for Pro users only."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    /// Filter for session type
    private var filterLabel: some View {
        HStack {
            Text(selectedFilter.rawValue)
            Image(systemName: "line.horizontal.3.decrease.circle")
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 8).fill(theme.mainColor))
        .shadow(radius: 2)
    }
    
    /// disables session type filter for list
    private func selectSessionFilter(_ filter: SessionFilter) {
            // Example logic to restrict certain filters to pro users
            switch filter {
            case .O2Table, .Co2Table:
                if !isProUser {
                    showingProAlert = true
                    // Do not change the filter; Optionally, guide them to upgrade
                    return
                }
            default:
                break
            }
            
            selectedFilter = filter
        }
    
    /// Session Total Counter
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
    
    /// Session History List
    @ViewBuilder
    private func sessionList(filteredSessions: [Session]) -> some View {
        ForEach(filteredSessions) { session in
            NavigationLink(destination: SessionHistoryDetailView(session: session)) {
                HStack {
                    TrainingHistoryCardView(image: session.image, title: session.sessionType.rawValue, date: session.date, duration: Double(session.duration))
                        .foregroundColor(.primary) // Ensure text color remains black

                }
                .swipeActions{
                    Button("Delete", role: .destructive) {
                        context.delete(session)
                    }
                }
            }
        }
    }
    
    /// disables charts if not Pro user
    private var customPickerBinding: Binding<ViewSection> {
        Binding(
            get: { self.selectedSection },
            set: {
                if $0 == .charts && !isProUser {
                    // Prevent changing to Charts if the user is not a pro user
                    showingProAlert = true
                } else {
                    self.selectedSection = $0
                }
            }
        )
    }

    /// checks the status of the user onAppear
    private func checkProStatus() {
        // Check the subscription status with RevenueCat
        Purchases.shared.getCustomerInfo { (purchaserInfo, error) in
            if let purchaserInfo = purchaserInfo {
                // Assuming "Pro" is your entitlement identifier on RevenueCat change Pro to No to test
                self.isProUser = purchaserInfo.entitlements["Pro"]?.isActive == true
            } else if let error = error {
                print("Error fetching purchaser info: \(error)")
            }
        }
    }
}
