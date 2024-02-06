//
//  Reminders.swift
//  ApneaManager
//
//  Created by andrew austin on 2/6/24.
//

import Foundation
import SwiftData
import SwiftUI

// Define the SwiftData model
@Model 
class TrainingReminder {
    @Attribute(.unique) var sessionType = ""
    var dueDate = Date.now + (60*60*24)
    var notes = ""
    
    
    init(sessionType: String = "", dueDate: Date = .now + (60*60*24), notes: String = "") {
        self.sessionType = sessionType
        self.dueDate = dueDate
        self.notes = notes
    }
}



