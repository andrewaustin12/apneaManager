//
//  SessionHistory.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import SwiftData

@Model
class Session {
    
    var image: String?
    var title: String
    var subTitle: String
    var date: Date
    //var time: String
    var duration: Double
    
    init(
        image: String? = nil,
        title: String,
        subTitle: String,
        date: Date = Date.now,
        //time: String,
        duration: Double
    ) {
        self.image = image
        self.title = title
        self.subTitle = subTitle
        self.date = date
        //self.time = time
        self.duration = duration
    }
    
}

//@Model
//class SessionHistory {
//    @Attribute var id: UUID
//    @Attribute var title: String
//    @Attribute var date: Date
//    @Attribute var duration: Int
//    @Attribute var type: String // e.g., "CO2 Training", "O2 Training"
//    
//    init(id: UUID = UUID(), title: String, date: Date, duration: Int, type: String) {
//        self.id = id
//        self.title = title
//        self.date = date
//        self.duration = duration
//        self.type = type
//    }
//}




