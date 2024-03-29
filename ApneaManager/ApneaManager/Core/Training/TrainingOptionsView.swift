//
//  TrainingOptionsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/5/24.
//

import SwiftUI
import SwiftData
import RevenueCat
import RevenueCatUI


struct TrainingOptionsView: View {
    @Environment(\.modelContext) private var context
    @EnvironmentObject var subscriptionManager: SubscriptionManager
    @Query var sessions: [Session]
    //@State var session: Session
    @State private var allSessions: [Session] = []
    @State private var personalBestDuration: String = "N/A"
    @State private var dragOffset: CGFloat = 0
    
    @State private var navigateToSquareBreathing = false
    @State private var isProUser: Bool = false
    @State private var showPaywall = false
    @State private var showNoValidSessionAlert = false
    @State private var showCO2Training = false
    @State private var showO2Training = false
    
    let theme: Theme
    
    /// finds most recent breath hold for LAST SESION
    private var mostRecentBreathHold: Session? {
        sessions
            .filter { $0.sessionType == .breathHold }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// finds most recent CO2 Table Session for LAST SESION
    private var mostRecentC02TableTraining: Session? {
        sessions
            .filter { $0.sessionType == .Co2Table }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// finds most recent O2 Table Session for LAST SESION
    private var mostRecent02TableTraining: Session? {
        sessions
            .filter { $0.sessionType == .O2Table }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// finds most recent PRE Breathe for LAST SESION
    private var mostRecentPreBreathe: Session? {
        sessions
            .filter { $0.sessionType == .prebreathe }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// finds most recent SQUARE BREATHING for LAST SESION
    private var mostRecentSquareBreathe: Session? {
        sessions
            .filter { $0.sessionType == .squareBreath }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// finds most recent PRANAYAMA for LAST SESION
    private var mostRecentPranayamaBreathe: Session? {
        sessions
            .filter { $0.sessionType == .pranayama }
            .sorted(by: { $0.date > $1.date })
            .first
    }
    
    /// Formats the time into 4m 32s
    private func formattedDuration(seconds: Double) -> String {
        if seconds < 60 {
            return "\(Int(seconds))s" // Just seconds
        } else {
            let minutes = Int(seconds) / 60
            let remainingSeconds = Int(seconds) % 60
            return "\(minutes)m \(remainingSeconds)s" // Minutes and seconds
        }
    }
    
    // Check if there are valid breath hold sessions
    private func hasValidBreathHoldSession() -> Bool {
        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
        return breathHoldSessions.contains { $0.duration > 0 }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader{ geometry in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 2) {
                            
                            NavigationLink(destination: BreathHoldView()) {
                                TrainingCardView(
                                    image: "freediver-3",
                                    title: "Breath Hold Test",
                                    subHeading: "Test Your Hold",
                                    description: "Start here to set your tables based on your best breath hold time."
                                )
                            }
                            
                            NavigationLink(destination: PreBreatheView()) {
                                TrainingCardView(
                                    image: "freediver-2",
                                    title: "Pre Breathe",
                                    subHeading: "TIME | 2:00",
                                    description: "Pre-breathing involves controlled breathing a exercise to balance oxygen and carbon dioxide levels."
                                )
                            }
                            
                            TrainingCardView(
                                image: "freediver-1",
                                title: "CO2 Training",
                                subHeading: "8 Rounds | 10 min",
                                description: "CO2 table is a series of breath hold sessions that give you less recovery time between each round."
                            )
                            .contentShape(Rectangle()) // Makes the entire area tappable
                            .onTapGesture {
                                if hasValidBreathHoldSession() {
                                    self.showCO2Training = true
                                } else {
                                    self.showNoValidSessionAlert = true
                                }
                            }
                            .background(
                                NavigationLink(destination: CO2TrainingView(), isActive: $showCO2Training) {
                                    EmptyView()
                                }
                                .hidden() // Ensure the NavigationLink does not affect layout
                            )
                            
                            TrainingCardView(
                                image: "freediver-8",
                                title: "O2 Training",
                                subHeading: "8 Rounds | 21 min",
                                description: "O2 table is a series of breath hold sessions that give you more apnea time each round."
                            )
                            .contentShape(Rectangle()) // Makes the entire area tappable
                            .onTapGesture {
                                if hasValidBreathHoldSession() {
                                    self.showO2Training = true
                                } else {
                                    self.showNoValidSessionAlert = true
                                }
                            }
                            .background(
                                NavigationLink(destination: O2TrainingView(), isActive: $showO2Training) {
                                    EmptyView()
                                }
                                .hidden() // Ensure the NavigationLink does not affect layout
                            )
                            
                            if subscriptionManager.isProUser {
                                NavigationLink(destination: SquareBreathingView(theme: theme)) {
                                    TrainingCardView(
                                        image: "freediver-7",
                                        title: "Square Table",
                                        subHeading: "4 Cycles | 5 min",
                                        description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                                    )
                                }
                            } else {
                                TrainingCardView(
                                    image: "freediver-7",
                                    title: "Square Table",
                                    subHeading: "4 Cycles | 5 min",
                                    description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                                )
                                .onTapGesture {
                                    showPaywall = true
                                }
                            }
                            
                            //                            NavigationLink(destination: PranayamaBreathingView(theme: theme)) {
                            //                                TrainingCardView(
                            //                                    image: "pranayama-2",
                            //                                    title: "Pranayama Breath",
                            //                                    subHeading: "4 Cycles | 5 min",
                            //                                    description: "Begin with 5-10 minutes of alternate nose breathing to relax."
                            //                                )
                            //                            }
                            if subscriptionManager.isProUser {
                                NavigationLink(destination: PranayamaBreathingView(theme: theme)) {
                                    TrainingCardView(
                                        image: "pranayama-2",
                                        title: "Pranayama Breath",
                                        subHeading: "4 Cycles | 5 min",
                                        description: "Begin with 5-10 minutes of alternate nose breathing to relax."
                                    )
                                }
                            } else {
                                TrainingCardView(
                                    image: "pranayama-2",
                                    title: "Pranayama Breath",
                                    subHeading: "4 Cycles | 5 min",
                                    description: "Begin with 5-10 minutes of alternate nose breathing to relax."
                                )
                                .onTapGesture {
                                    showPaywall = true
                                }
                            }
                        }
                        //.padding(.leading)
                        .offset(x: self.dragOffset, y: 0)
                        .gesture(
                            DragGesture().onChanged { value in
                                self.dragOffset = value.translation.width
                            }
                                .onEnded { value in
                                    // You can add further logic here to "snap" to a card
                                    // For simplicity, we're just resetting the drag offset
                                    withAnimation(.easeInOut) {
                                        self.dragOffset = 0
                                    }
                                }
                        )
                    }
                }
                .frame(height: 220)
                
                HStack{
                    Text("Sessions")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.leading)
                .padding(.top)
                
                List {
                    
                    if sessions.count >= 1 {
                        /// Personal Best Breath Hold
                        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
                        if let longestBreathHoldSession = Session.longestSessionByType(sessions: breathHoldSessions) {
                            HStack {
                                Image("trophy")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                    .frame(width: 45, height: 45)
                                VStack(alignment: .leading) {
                                    Text("Personal Best")
                                        .font(.headline)
                                    Text("Breath Hold ")
                                        .font(.subheadline)
                                }
                                Spacer()
                                VStack {
                                    Text( formattedDuration(seconds: Double(longestBreathHoldSession.duration)))
                                }
                                .font(.headline)
                                
                            }
                        }
                        
                        /// Last Session Breath Hold
                        if let mostRecentBreathHoldSession = mostRecentBreathHold {
                            TrainingLastSessionCard(image: "freediver-3", sessionType: "Breath Hold Test", duration: mostRecentBreathHoldSession.duration)
                        }
                        
                        /// Last Session: Prebreathe
                        if let mostRecentPreBreatheSession = mostRecentPreBreathe {
                            TrainingLastSessionCard(image: "freediver-2", sessionType: "Pre Breathe", duration: mostRecentPreBreatheSession.duration)
                        }
                        /// Last Session : CO2  Table
                        if let mostRecentC02TableTraining = mostRecentC02TableTraining {
                            TrainingLastSessionCard(image: "freediver-1", sessionType: "CO2 Table", duration: mostRecentC02TableTraining.duration)
                        }
                        
                        /// Last Session: O2 Table
                        if let mostRecent02TableTraining = mostRecent02TableTraining {
                            TrainingLastSessionCard(image: "freediver-8", sessionType: "O2 Table", duration: mostRecent02TableTraining.duration)
                        }
                        /// Last Session: Square Breath
                        if let mostRecentSquareBreathe = mostRecentSquareBreathe {
                            TrainingLastSessionCard(image: "freediver-7", sessionType: "Square Breath", duration: mostRecentSquareBreathe.duration)
                        }
                        /// Last Session: Pranayama
                        if let mostRecentPranayamaBreathe = mostRecentPranayamaBreathe {
                            TrainingLastSessionCard(image: "pranayama-2", sessionType: "Pranayama Breathe", duration: mostRecentPranayamaBreathe.duration)
                        }
                        
                    } else {
                        ContentUnavailableView(label: {
                            Label("No Training Session", systemImage: "list.bullet.rectangle.portrait")
                        }, description: {
                            Text("Complete your first session to see your most recent trainings")
                                .padding()
                        })
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
            .navigationTitle("Training")
            .alert(isPresented: $showNoValidSessionAlert) {
                Alert(
                    title: Text("Complete A Breath Hold Test"),
                    message: Text("To unlock this training please complete a breath hold test. It is used to create your training table."),
                    dismissButton: .default(Text("OK"))
                )
            }
            .sheet(isPresented: $showPaywall, content: {
                PaywallView(displayCloseButton: true)
            })
            .presentPaywallIfNeeded(requiredEntitlementIdentifier: "Pro")
        }
    }
    
    private func timeString(from totalSeconds: Int) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TrainingOptionsView(theme: .bubblegum)
}


