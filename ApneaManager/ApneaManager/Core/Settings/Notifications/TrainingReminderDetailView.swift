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
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Enter Session Type here", text: $trainingReminder.sessionType)
                        .font(.title)
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
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Notification Scheduled"),
                            message: Text("Your notification for this item has been scheduled."),
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
        .onAppear(perform: {
            notify.askPermission()
        })
    }
}


#Preview {
    NavigationStack {
        TrainingReminderDetailView(trainingReminder: TrainingReminder())
        
    }
    .modelContainer(for: TrainingReminder.self)
}
