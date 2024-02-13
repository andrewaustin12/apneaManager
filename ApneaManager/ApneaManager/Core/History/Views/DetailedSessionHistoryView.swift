//
//  DetailedSessionHistoryView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/10/24.
//

import SwiftUI

struct DetailedSessionHistoryView: View {
    //let date: String
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Detailed Session History")
                    .font(.largeTitle)
            }
            Spacer()
            VStack {
                Text("12/24/23")
            }
            Spacer()
        }
    }
}

#Preview {
    DetailedSessionHistoryView()
}
