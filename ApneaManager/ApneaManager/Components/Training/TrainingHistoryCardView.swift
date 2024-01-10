//
//  TrainingHistoryCard.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct TrainingHistoryCardView: View {
    let image: String
    let title: String
    let subTitle: String
    let date: String
    let time: String
    var body: some View {
        
        HStack {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(.leading, 10)
            
            
            VStack(alignment: .leading) {
                Text(subTitle)
                    .font(.subheadline)
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            VStack(alignment: .trailing) {
                Text(date)
                Text(time)
            }
            .padding(.trailing)
            .font(.callout)
            .bold()
            
        }
        .frame(height: 60)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8) // Apply the corner radius to the overlay as well.
                .stroke(Color.white, lineWidth: 1)
        )
        
        
    }
}

#Preview {
    TrainingHistoryCardView(image: "freediver-1", title: "Breath Hold", subTitle: "Session type:", date: "26 May",time: "2:42")
}
