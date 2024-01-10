//
//  CardView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/5/24.
//

import SwiftUI

struct TraningCardView: View {
    let image: String
    let title: String
    let subHeading: String
    let description: String
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 320, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20) // Apply the corner radius to the overlay as well.
                        .stroke(Color.gray, lineWidth: 2)
                )
                
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(subHeading)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.caption)
                    .bold()
                    .foregroundColor(.white)
                    .lineLimit(2)
            }
            .padding()
        }
        .frame(width: 320, height: 200)
        .background(Color.black.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    TraningCardView(image: "freediver-1", title: "CO2 Training", subHeading: "4 CYCLES | TIME - 2:00", description: "Pre-breathing involves controlled breathing exercises to balance oxygen and carbon dioxide levels")
}
