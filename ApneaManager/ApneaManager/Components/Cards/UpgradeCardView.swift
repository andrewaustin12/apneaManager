//
//  UpgradeCardView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI
import RevenueCatUI

struct UpgradeCardView: View {
    let image: String
    let title: String
    let buttonLabel: String
    @Environment(\.colorScheme) var colorScheme
    @State private var isShowingPaywall = false
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 2)
                )
            
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 1)
                
                Button(buttonLabel) {
                    isShowingPaywall = true
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
        .shadow(color: colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.3), radius: 5, x: 0, y: 3)
        .sheet(isPresented: $isShowingPaywall, content: {
            PaywallView()
        })
    }
}

#Preview {
    UpgradeCardView(image: "freediver-3", title: "Upgrade to pro", buttonLabel: "Learn more")
}
