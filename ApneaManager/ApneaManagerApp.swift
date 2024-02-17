//
//  ApneaManagerApp.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI
import SwiftData
import WishKit
import StoreKit
import HealthKit
import RevenueCat
import RevenueCatUI

@main
struct ApneaManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let container: ModelContainer
    @StateObject private var store = TipStore()
    @StateObject private var healthKitManager = HealthKitManager()

    // Using AppStorage to save and retrieve the user's selected theme
    @AppStorage("selectedTheme") var selectedThemeRawValue: String = Theme.primary.rawValue // Default theme
    private var selectedTheme: Theme {
        Theme(rawValue: selectedThemeRawValue) ?? .primary // Fallback to default theme
    }
    
    var body: some Scene {
        WindowGroup {
            WarningView() // Assuming WarningView doesn't actually need the theme passed directly to it.
                .environment(\.selectedTheme, selectedTheme) // Correctly setting the environment value.
                .modelContainer(container)
                .environmentObject(store)
                .environmentObject(healthKitManager)
                .accentColor(selectedTheme.mainColor) // Applying the main color of the selected theme as the accent color of the app.
                .environmentObject(SubscriptionManager.shared)
        }
        
    }
    
    init() {
        WishKit.configure(with: "BCC8A2F9-BF8D-4EE0-B4B9-CFACB7101011")
        WishKit.config.buttons.addButton.bottomPadding = .large
        WishKit.theme.primaryColor = .accentColor
        WishKit.config.buttons.addButton.textColor = .setBoth(to: .white)
        WishKit.config.buttons.saveButton.textColor = .setBoth(to: .white)
        
        /// RevenueCat
        Purchases.configure(withAPIKey: "appl_ByZIIVEeQyrtAvjeKUflGkyECho")
        
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

// Extend the EnvironmentValues to include the selected theme
struct SelectedThemeKey: EnvironmentKey {
    static let defaultValue: Theme = .bubblegum // Default theme
}

extension EnvironmentValues {
    var selectedTheme: Theme {
        get { self[SelectedThemeKey.self] }
        set { self[SelectedThemeKey.self] = newValue }
    }
}
