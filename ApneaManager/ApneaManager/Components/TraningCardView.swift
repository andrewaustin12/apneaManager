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
                        .stroke(Color.white, lineWidth: 4)
                )
                
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Text(subHeading)
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Text(description)
                    .font(.caption)
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
    TraningCardView(image: "freediver-1", title: "CO2 Training", subHeading: "16 CYCLES | TIME - 11:32", description: "CO2 table is a series of breath hold sessions that give you less time to recover between them.")
}
