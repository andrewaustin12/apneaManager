//
//  TrainingLastSessionCard.swift
//  ApneaManager
//
//  Created by andrew austin on 1/28/24.
//

import SwiftUI

struct TrainingLastSessionCard: View {
    let image: String
    let sessionType: String
    let duration: Int
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 45, height: 45)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.3), radius: 2, x: 0, y: 1)
            
            
            VStack(alignment: .leading) {
                Text("Last Session")
                    .font(.subheadline)
                Text(sessionType)
                    .font(.headline)
            }
            //.frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
            VStack {
                Text(formattedDuration(seconds: Double(duration)))
            }
            .font(.headline)
        }
    }
    
    private func formattedDuration(seconds: Double) -> String {
        if seconds < 60 {
            return "\(Int(seconds))s" // Just seconds
        } else {
            let minutes = Int(seconds) / 60
            let remainingSeconds = Int(seconds) % 60
            return "\(minutes)m \(remainingSeconds)s" // Minutes and seconds
        }
    }
}

#Preview {
    TrainingLastSessionCard(image: "freediver-1", sessionType: "CO2 Table", duration: 182)
}
