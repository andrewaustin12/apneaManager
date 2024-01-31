//
//  PersonalBestBreathHold.swift
//  ApneaManager
//
//  Created by andrew austin on 1/11/24.
//

import Foundation
import SwiftData

@Model
class PersonalBestBreatholdSession {
    var duration: Int
    var date: Date
    var isPersonalBest: Bool
    
    

    init(
        duration: Int,
        date: Date = Date.now,
        isPersonalBest: Bool = false
    ) {
        self.duration = duration
        self.date = date
        self.isPersonalBest = isPersonalBest
    }
}


