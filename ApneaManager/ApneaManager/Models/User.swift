//
//  User.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import Foundation

struct User: Identifiable {
    let id: UUID
    var theme: Theme
    var history: [SessionHistory] = []
    
    init(id: UUID = UUID(), theme: Theme) {
        self.id = id
        self.theme = theme
    }
}

extension User {
    static let sampleData: [User] =
    [
        User(id: UUID(), theme: .buttercup)
    ]
}
