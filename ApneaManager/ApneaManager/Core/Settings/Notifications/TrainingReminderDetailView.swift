//
//  TrainingReminderDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 2/6/24.
//

import SwiftUI
import SwiftData

struct TrainingReminderDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State var trainingReminder: TrainingReminder
    @Environment(\.modelContext) var modelContext
    let notify = NotificationHandler()
    @State private var selectedDate = Date()
    @State private var isNotificationScheduled = false // Flag to track whether a notification is scheduled
    @State private var isDateChanged = false // Flag to track if the date is changed
    @State private var showAlert: Bool = false
    
    @State private var selectedSessionType = ""
    let sessionTypes = [
        "Breath Hold Test",
        "Pre Breathe",
        "O2 Table",
        "CO2 Table",
        "Square Breathe",
        "Paranayama Breathe"
    ]
        
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Picker("Session Type", selection: $selectedSessionType) {
                            ForEach(sessionTypes, id: \.self) { sessionType in
                                Text(sessionType).tag(sessionType)
                            }

                        }
                        .onAppear {
                            // Set the initial selectedSessionType if needed
                            selectedSessionType = trainingReminder.sessionType
                        }
                        .onChange(of: selectedSessionType) { newValue in
                            trainingReminder.sessionType = newValue
                        }
                    }
                    VStack {
                        
                        TextField("Leave a note if needed ", text: $trainingReminder.notes, axis: .vertical)
                    }
                }
                
                Section {
                    VStack {
                        DatePicker("Select Date and Time", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                    }
                    Button("Schedule Training") {
                        if !isNotificationScheduled {
                            notify.sendNotification(
                                date: selectedDate,
                                type: "date",
                                title: "Reminder: \(trainingReminder.sessionType)",
                                body: "\(trainingReminder.notes)")
                            isNotificationScheduled = true // Mark the notification as scheduled
                            showAlert = true // Trigger the alert
                        }
                    }
                    .disabled(selectedSessionType.isEmpty)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Training Scheduled"),
                            message: Text("Your notification for this training session has been scheduled."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    modelContext.insert(trainingReminder)
                    dismiss()
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
                    // Initialize with default session type if not already set
                    if trainingReminder.sessionType.isEmpty {
                        trainingReminder.sessionType = "Breath Hold Test"
                        selectedSessionType = trainingReminder.sessionType
                    } else {
                        // Ensure selectedSessionType matches the current trainingReminder session type
                        selectedSessionType = trainingReminder.sessionType
                    }
                    notify.askPermission()
                }
    }
}


#Preview {
    NavigationStack {
        TrainingReminderDetailView(trainingReminder: TrainingReminder())
        
    }
    .modelContainer(for: TrainingReminder.self)
}
