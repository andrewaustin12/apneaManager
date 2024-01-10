//
//  ApneaManagerApp.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI
import WishKit

@main
struct ApneaManagerApp: App {
    
    init() {
        WishKit.configure(with: "BCC8A2F9-BF8D-4EE0-B4B9-CFACB7101011")
        WishKit.config.buttons.addButton.bottomPadding = .large
        WishKit.theme.primaryColor = .accentColor
        WishKit.config.buttons.addButton.textColor = .setBoth(to: .white)
        WishKit.config.buttons.saveButton.textColor = .setBoth(to: .white)
        }
    
    var body: some Scene {
        WindowGroup {
            MainTab()
        }
    }
}
