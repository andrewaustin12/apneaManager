//
//  TimerNotificationView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI

struct TimerNotificationView: View {
    @State private var isMinuteNotificationChecked = false
    @State private var is10SecondsNotificationChecked = false
    
    var body: some View {
        NavigationStack {
            List {
                Toggle("Minute Notification", isOn: $isMinuteNotificationChecked)
                Toggle("10 Seconds Notification", isOn: $is10SecondsNotificationChecked)
            }
            .navigationTitle("Timer Notifications")
        }
    }
}

#Preview {
    TimerNotificationView()
}
