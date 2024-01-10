//
//  UpgradeCardView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct UpgradeCardView: View {
    let image: String
    let title: String
    let buttonLabel: String
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20) // Apply the corner radius to the overlay as well.
                        .stroke(Color.gray, lineWidth: 2)
                )
                
            
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                
                Button(buttonLabel) {
                    print("upgrade to pro")
                }
                .bold()
                .buttonStyle(.borderedProminent)
                .padding(.bottom, 5)
                .padding(.top, 0)
                
            }
            
        }
        .frame(width: 350, height: 100)
        .background(Color.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
}
