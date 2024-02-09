//
//  SettingsView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI
import WishKit

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme // Detect the color scheme
    @State var userTheme: Theme
    @State var isPreBreatheChecked: Bool = false
    @State var isVibrationChecked: Bool = false
    @State var isAudioGuidanceChecked: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Apnea Manager")
                    .font(.largeTitle)
                    .fontWeight(.bold) // Make the title bold
                    //.foregroundColor(colorScheme == .light ? .black : .white) // Change the text color
                    .padding(.bottom, 10)
                VStack {
                    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
                }
                
                .padding(.bottom)
            }
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .padding(.bottom, -10)
            
            VStack {
                
                List {
                    
//                    Section{
//                        Toggle(isOn: $isVibrationChecked) {
//                            Label("Vibrations", systemImage: "iphone.gen3.radiowaves.left.and.right")
//                        }
//                        
//                    } header: {
//                        Text("User Settings")
//                    }
//                    Section{
//                        NavigationLink(destination: TrainingRemindersView()) {
//                            Label("Training Reminders", systemImage: "bell.badge")
//                        }
//                        NavigationLink(destination: TimerNotificationView()) {
//                            Label("Timer Notifications", systemImage: "clock")
//                        }
//                    } header: {
//                        Text("Notifications")
//                    }
                    
                    /// IF is not a PRO user DISABLE
                    Section{
                        HStack {
                            Label("Theme", systemImage: "paintpalette")
                            Spacer()
                            NavigationLink(destination: ThemePicker()) {
                            }
                        }
                        NavigationLink(destination: TrainingRemindersView()) {
                            Label("Training Reminders", systemImage: "bell.badge")
                        }
                        NavigationLink(destination: TimerNotificationView()) {
                            Label("Audio Guidance Options", systemImage: "person.wave.2")
                        }
                        
                        
                        
                    } header: {
                        Text("Pro Settings")
                    }
                    
                    
                    Section("Support"){
                        NavigationLink(destination: WishKit.view) {
                            Label("Feature Request", systemImage: "lightbulb.min")
                        }
                        
                        NavigationLink(destination: BuyMeACoffeeView()) {
                            Label("Buy me a coffee", systemImage: "mug.fill")
                        }
                        
                        Label{
                            Text("Feedback")
                        } icon: {
                            Image(systemName: "envelope")
                        }
                        .onTapGesture {
                            sendEmail()
                        }
                        
                        Label {
                            HStack {
                                Text("Rate in the App Store")
                                Spacer() // This will push the text and icon to opposite ends
                                Image(systemName: "link") // The link icon
                                    .foregroundColor(.blue)
                            }
                        } icon: {
                            Image(systemName: "star.circle.fill")
                                .foregroundColor(Color.yellow)
                        }
                        .onTapGesture {
                            openAppStoreForRating()
                        }
                        
                        
                    }
                }
                .listStyle(PlainListStyle())
            }
            //            .navigationTitle("Apnea Manager")
            //.scrollIndicators(.hidden)
            
            /// IF user is upgraded to PRO this should not show. wrap the whole view in an IF ELSE statement.
            .navigationBarHidden(true)
        }
    }
    
}


#Preview {
    SettingsView(userTheme: .buttercup)
}

func openAppStoreForRating() {
    guard let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID") else {
        return // Invalid URL
    }
    if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url)
    }
}

private func sendEmail() {
    let email = "andyaustin_dev@yahoo.com"
    if let url = URL(string: "mailto:\(email)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

/// To make the text a link. Ex: Text(linkText("Rate in App Store"))
func linkText(_ text: String) -> AttributedString {
    var attributedString = AttributedString(text)
    if let range = attributedString.range(of: text) {
        attributedString[range].foregroundColor = .blue
        attributedString[range].underlineStyle = .single
    }
    return attributedString
}

