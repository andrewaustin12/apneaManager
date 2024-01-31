//
//  Session.swift
//  ApneaManager
//
//  Created by andrew austin on 1/17/24.
//

import Foundation
import SwiftData

@Model
final class Session: Identifiable, Hashable {
    var id = UUID()
    var date = Date()
    var image: String
    var sessionType: SessionType
    var duration: Int // Duration in seconds

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        image: String,
        sessionType: SessionType,
        duration: Int
    ) {
        self.id = id
        self.date = date
        self.image = image
        self.sessionType = sessionType
        self.duration = duration

    }
}

extension Session {
    enum SessionType: String, CaseIterable, Codable {
        case breathHold = "Breath Hold"
        case prebreathe = "Pre Breathe"
        case O2Table = "O2 Table"
        case Co2Table = "Co2 Table"
        case squareBreath = "Square Breath"
        case pranayama = "Pranayama"
    }
}


extension Session {
    static func longestSessionByType(sessions: [Session]) -> Session? {
        return sessions
            .sorted {
                if $0.sessionType == $1.sessionType {
                    return $0.duration > $1.duration
                }
                return $0.sessionType.rawValue < $1.sessionType.rawValue
            }
            .first
    }
}




