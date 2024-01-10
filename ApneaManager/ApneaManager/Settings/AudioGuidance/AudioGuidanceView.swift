//
//  AudioGuidanceView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct AudioGuidanceView: View {
    @State private var isCDRestChecked: Bool = false
    @State private var isCDApneaChecked: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Toggle(isOn: $isCDRestChecked, label: {
                    Text("Countdown in Rest")
                })
                Toggle(isOn: $isCDApneaChecked, label: {
                    Text("Countdown in Anea")
                })
            }
            .navigationTitle("Audio Guidance")
        }
    }
}

#Preview {
    NavigationStack {
        AudioGuidanceView()
    }
}
