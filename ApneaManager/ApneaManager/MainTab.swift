//
//  MainTab.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI

struct MainTab: View {
    @State private var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            TrainingOptionsView()
                .onAppear{
                    selectedIndex = 0
                }
                .tabItem{
                    Image(systemName: "timer")
                    Text("Training")
                }.tag(0)
            
            Text("Exercises")
                .onAppear{
                    selectedIndex = 1
                }
                .tabItem{
                    Image(systemName: "figure.mind.and.body")
                    Text("Exercises")
                }.tag(1)
            GuidanceListView()
                .onAppear{
                    selectedIndex = 2
                }
                .tabItem{
                    Image(systemName: "pencil.and.list.clipboard")
                    Text("Guidance")
                }.tag(2)
            Text("History")
                .onAppear{
                    selectedIndex = 3
                }
                .tabItem{
                    Image(systemName: "list.dash")
                    Text("History")
                }.tag(3)
            SettingsView()
                .onAppear{
                    selectedIndex = 4
                }
                .tabItem{
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(4)
            
        }
    }
}

#Preview {
    MainTab()
}
