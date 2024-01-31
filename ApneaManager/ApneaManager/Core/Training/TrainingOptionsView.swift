//
//  TrainingOptionsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/5/24.
//

import SwiftUI
import SwiftData


struct TrainingOptionsView: View {
    @Environment(\.modelContext) private var context
    @Query var sessions: [Session]
    //@State var session: Session
    @State private var allSessions: [Session] = []
    @State private var personalBestDuration: String = "N/A"
    
    
    /// finds most recent breath hold for LAST SESION
    private var mostRecentBreathHold: Session? {
        sessions
            .filter { $0.sessionType == .breathHold }
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
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        
                        NavigationLink(destination: BreathHoldView()) {
                            TraningCardView(
                                image: "freediver-3",
                                title: "Breath Hold Test",
                                subHeading: "Test Your Hold",
                                description: "Start here to set your tables based on your best breath hold time."
                            )
                        }
                        
                        NavigationLink(destination: PreBreatheView()) {
                            TraningCardView(
                                image: "freediver-2",
                                title: "Pre Breathe",
                                subHeading: "TIME - 2:00",
                                description: "Pre-breathing involves controlled breathing a exercise to balance oxygen and carbon dioxide levels."
                            )
                        }
                        
                        NavigationLink(destination: CO2TrainingView()) {
                            TraningCardView(
                                image: "freediver-1",
                                title: "CO2 Training",
                                subHeading: "16 CYCLES | TIME - 11:32",
                                description: "CO2 table is a series of breath hold sessions that give you less time to recover between them."
                            )
                        }
                        
                        NavigationLink(destination: O2TrainingView()) {
                            TraningCardView(
                                image: "freediver-5",
                                title: "O2 Training",
                                subHeading: "8 CYCLES | TIME - 22:32",
                                description: "CO2 table is a series of breath hold sessions that give you less time to recover between them."
                            )
                        }
                        
                        NavigationLink(destination: SquareBreathingView()) {
                            TraningCardView(
                                image: "freediver-4",
                                title: "Square Table",
                                subHeading: "10 Cycles - 4 in 4 out",
                                description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                            )
                        }
                        
                        NavigationLink(destination: PranayamaBreathingView()) {
                            TraningCardView(
                                image: "pranayama-1",
                                title: "Pranayama Breath",
                                subHeading: "10 Cycles - 4 in 4 out",
                                description: "Begin with 5-10 minutes of square breathing to prepare for the breath-hold exercises."
                            )
                        }
                        
                    }
                }
                .padding()
                
                HStack{
                    Text("Sessions")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding(.leading)
                
                List {
                    
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
                    
                    TrainingLastSessionCard(image: "freediver-1", sessionType: "CO2 Table", duration: 184)
                    
                    /// Last Session: O2 Table
                    TrainingLastSessionCard(image: "freediver-5", sessionType: "O2 Table", duration: 198)
                    
                    /// Last Session: Square Breath
                    if let mostRecentSquareBreathe = mostRecentSquareBreathe {
                        TrainingLastSessionCard(image: "freediver-4", sessionType: "Square Breath", duration: mostRecentSquareBreathe.duration)
                    }
                    /// Last Session: Pranayama
                    TrainingLastSessionCard(image: "pranayama-1", sessionType: "Pranayama Breathe", duration: 322)
                    
                    
                }
                .listStyle(.plain)
//                ScrollView {
//                    VStack(alignment: .leading){
////                        let breathHoldSessions = sessions.filter { $0.sessionType == .breathHold }
////                        if let longestBreathHoldSession = Session.longestSessionByType(sessions: breathHoldSessions) {
////                            TrainingTimeCardView(
////                                image: "trophy",
////                                title: "Personal Best",
////                                subTitle: "BREATH HOLD",
////                                time: formattedDuration(seconds: Double(longestBreathHoldSession.duration))
////                                
////                            )
////                        }
//                        if let mostRecentSession = mostRecentBreathHold {
//                            TrainingTimeCardView(
//                                image: "freediver-3",
//                                title: "Last Session",
//                                subTitle: "BREATH HOLD Test",
//                                time: formattedDuration(seconds: Double(mostRecentSession.duration))
//                            )
//                        }
//                        TrainingTimeCardView(image: "freediver-1", title: "Last Session", subTitle: "CO2 TABLE", time: "2m 42s")
//                        TrainingTimeCardView(image: "freediver-2", title: "Last Session", subTitle: "O2 TABLE", time: "3m 42s")
//                        
//                        TrainingTimeCardView(image: "freediver-4", title: "Last Session", subTitle: "SQUARE BREATHING", time: "13m 42s")
//                        TrainingTimeCardView(image: "pranayama-1", title: "Last Session", subTitle: "PRANAYAMA BREATHING", time: "20:42")
//                        
//                    }
//                }
                //.padding(.leading)
                //.padding(.trailing)
                .scrollIndicators(.hidden)
                
                
            }
            .navigationTitle("Training")
        }
        
    }
    private func timeString(from totalSeconds: Int) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    TrainingOptionsView()
}


