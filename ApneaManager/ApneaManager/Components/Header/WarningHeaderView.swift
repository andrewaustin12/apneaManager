//
//  WarningHeaderView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/17/24.
//

import SwiftUI

import SwiftUI

struct WarningHeaderView: View {
    let title1: String
    let title2: String
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack { Spacer() }
            
            Text(title1)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(title2)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
        }
        .frame(height: 200)
        .padding(.leading)
        .background(Color(.systemBlue))
        .foregroundColor(.white)
        .clipShape(RoundedShape(corners: [.bottomRight]))
    }
}

#Preview {
    WarningHeaderView(title1: "Apnea", title2: "Manager")
}
