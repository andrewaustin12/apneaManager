//
//  TrainingRemindersView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI

struct TrainingRemindersView: View {
    @State private var reminderEnabled = false
    @State private var selectedTime = Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Daily Reminder")) {
                    Toggle("Enable Reminder", isOn: $reminderEnabled)
                    
                    if reminderEnabled {
                        DatePicker("Select Time", selection: $selectedTime, displayedComponents: .hourAndMinute)
                    }
                }
            }
            .navigationBarTitle("Training Reminder")
        }
    }
}

#Preview {
    TrainingRemindersView()
}
