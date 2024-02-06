//
//  TrainingRemindersView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI
import UserNotifications
import SwiftData


struct TrainingRemindersView: View {
    @State private var sheetIsPresented = false
    @Query var trainingReminders: [TrainingReminder]
    @Environment(\.modelContext) var modelContext
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                
                List {
                    Section {
                        ForEach(trainingReminders) { trainingReminder in
                                
                                NavigationLink {
                                    TrainingReminderDetailView(trainingReminder: trainingReminder)
                                } label: {
                                    if trainingReminder.notes.isEmpty {
                                        Text(trainingReminder.sessionType)
                                    } else {
                                        VStack(alignment: .leading) {
                                            Text(trainingReminder.sessionType)
                                            Text(trainingReminder.notes)
                                                .font(.caption)
                                        }
                                    }

                            }
                            .font(.title2)
                            .swipeActions{
                                Button("Delete", role: .destructive) {
                                    modelContext.delete(trainingReminder)
                                }
                            }
                        }
                    } header: {
                        Text("Training Reminders")
                            .font(.title2)
                            .bold()
                            //.foregroundStyle()
                    }
                    
                }
                
                Button {
                    sheetIsPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.blue)
                        .accentColor(.white)
                        .frame(width: 60, height: 60)
                        .padding()
                }
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $sheetIsPresented) {
                    NavigationStack {
                        TrainingReminderDetailView(trainingReminder: TrainingReminder()) // new value
                    }
                }
                
            }
            .overlay {
                if trainingReminders.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Trainings Scheduled", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding training sessions to see your list.")
                    })
                    .offset(y: -60)
                }
            }
        }
    }
}

#Preview {
    TrainingRemindersView()
}
