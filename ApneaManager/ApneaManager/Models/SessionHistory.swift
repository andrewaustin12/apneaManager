//
//  SessionHistory.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct SessionHistory: Identifiable, Hashable {
    var id = UUID()
    
    var image: String
    var title: String
    var subTitle: String
    var date: String
    var time: String
    var duration: Double // Duration in seconds
    
}
