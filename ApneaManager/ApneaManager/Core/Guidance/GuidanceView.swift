//
//  GuidanceView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/4/24.
//

import SwiftUI

struct GuidanceView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("How to do dry static apnea training")
                    .font(.title3).bold()
            }
            List {
                Section("Step 1") {
                    Text("Start by laying down on the ground. I recommend laying on a nice yoga mat.")
                }
                Section("Step 2") {
                    Text("Set your desired time with your appropriate CO2 or O2 Table.")
                }
                Section("Step 3") {
                    Text("Do a standard pre-dive breathe-up. In simple terms all you want to do is exhale for twice as long as you inhale. And you do this for about 2 minutes before your apnea training. So if you breathe in for 5 seconds, exhale gently for 10 seconds. Now repeat this for 2 minutes.")
                }
                Section("Step 4") {
                    Text("After your breathe-up, exhale all your air completely out to empty your lungs.")
                }
                Section("Step 5") {
                    Text("Take your last inhale so your lungs are about 95% full of air. Start with your stomach and then fill up your lungs. Don’t over pack or over-inhale. Not only is this bad practice for real breath-hold freediving; but it also causes you to be uncomfortable and breaks relaxation.")
                }
                Section("Step 6") {
                    Text("Start your timer or table. The app automatically calculates your table based on your personal best breath hold.")
                }
                Section("Step 7") {
                    Text("While holding your breath, close your eyes. Visualize yourself in an underwater environment you find relaxing.")
                }
                Section("Step 8") {
                    Text("When you start feeling contractions at – say – 1:20 to 1:50; lower your chin down to your chest. This will increase your comfort and is good practice.")
                }
                Section("Step 9") {
                    Text("Toward the end of your Dry Static Breath-Hold, visualize yourself swimming back up to the surface.")
                }
                Section("Step 9") {
                    Text("Toward the end of your Dry Static Breath-Hold, visualize yourself swimming back up to the surface.")
                }
                Section("Step 10") {
                    Text("Open your eyes, inhale with 3 – 5 hook breaths (recovery breaths).")
                    Text("To hook breathe: \nInhale, push down for 1 second, exhale and repeat. Do this 3 – 5 times.")
                }
            }
            .listStyle(.plain)
            .listSectionSpacing(1.0)
        }
    }
}

#Preview {
    GuidanceView()
}
