//
//  ApneaManagerApp.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI
import WishKit
import SwiftData
import StoreKit

@main
struct ApneaManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let container: ModelContainer
    @StateObject private var store = TipStore()
    
    
    
    var body: some Scene {
        WindowGroup {
            WarningView()
                //.modelContainer(for: [TrainingReminder.self ,Session.self])
                .modelContainer(container)
                .environmentObject(store)
        }
        
    }
    
    init() {
        WishKit.configure(with: "BCC8A2F9-BF8D-4EE0-B4B9-CFACB7101011")
        WishKit.config.buttons.addButton.bottomPadding = .large
        WishKit.theme.primaryColor = .accentColor
        WishKit.config.buttons.addButton.textColor = .setBoth(to: .white)
        WishKit.config.buttons.saveButton.textColor = .setBoth(to: .white)
        
        
        let schema = Schema([TrainingReminder.self ,Session.self])
        let config = ModelConfiguration("ApneaManager", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
        }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle the notification when the app is in the foreground.
        // You can customize the presentation options here.
        completionHandler([.banner, .sound])
    }
}
