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

    let date: Date
    let duration: Double
    
    private func formattedDuration(seconds: Double) -> String {
            if seconds < 60 {
                return "\(Int(seconds))s" // Just seconds
            } else {
                let minutes = Int(seconds) / 60
                let remainingSeconds = Int(seconds) % 60
                return "\(minutes)m \(remainingSeconds)s" // Minutes and seconds
            }
        }

    var body: some View {
        
        HStack {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                //.padding(.leading, 10)
            
            
            VStack(alignment: .leading) {
                Text("Session Type:")
                    .font(.subheadline)
                Text(title)
                    .font(.headline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            VStack(alignment: .trailing) {
                Text("\(date, format: Date.FormatStyle().month().day())")
                Text(formattedDuration(seconds: duration))
            }
            //.padding(.trailing)
            .font(.callout)
            .bold()
            
        }
//        .frame(height: 60)
//        .background(.ultraThinMaterial)
//        .clipShape(RoundedRectangle(cornerRadius: 8))
//        .overlay(
//            RoundedRectangle(cornerRadius: 8) // Apply the corner radius to the overlay as well.
//                .stroke(Color.white, lineWidth: 1)
//        )
        
        
    }
}

#Preview {
    TrainingHistoryCardView(image: "freediver-1", title: "Breath Hold", date: Date.distantPast, duration: 243)
}
