//
//  ThemePicker.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct ThemePicker: View {
    @State var selection: Theme
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text("Pick your theme")
                    .font(.title)
            }
            Picker("Theme", selection: $selection) {
                ForEach(Theme.allCases) { theme in
                    ThemeView(theme: theme)
                        .tag(theme)
                }
                
            }
            .padding()
            .pickerStyle(.navigationLink)
            
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    ThemePicker(selection: .buttercup)
}
