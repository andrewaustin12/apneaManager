//
//  Reminders.swift
//  ApneaManager
//
//  Created by andrew austin on 2/6/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class TrainingReminder {
    var id: UUID = UUID() // Add a unique identifier
    var sessionType = ""
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    
    init(id: UUID = UUID(), sessionType: String = "", dueDate: Date = Date.now + (60*60*24), notes: String = "") {
        self.id = id
        self.sessionType = sessionType
        self.dueDate = dueDate
        self.notes = notes
    }
}




