//
//  TimerNotificationView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI

struct TimerNotificationView: View {
    @AppStorage("isMinuteNotificationChecked") var isMinuteNotificationChecked: Bool = false
    @AppStorage("is10SecondsNotificationChecked") var is10SecondsNotificationChecked: Bool = false

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
