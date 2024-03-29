//
//  TrainingTimeCardView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/6/24.
//

import SwiftUI

struct TrainingTimeCardView: View {
    let image: String
    let title: String
    let subTitle: String
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
                Text(title)
                    .font(.headline)
                Text(subTitle)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            VStack {
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
                .stroke(Color.gray, lineWidth: 1)
        )
        
        
    }
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60

        if minutes == 0 {
            return "\(seconds)s"
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }

}

#Preview {
    TrainingTimeCardView(image: "freediver-1", title: "Personal Best", subTitle: "Breath Hold", time: "2:42")
}
