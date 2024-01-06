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
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            
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
        .overlay(
            RoundedRectangle(cornerRadius: 8) // Apply the corner radius to the overlay as well.
                .stroke(Color.gray, lineWidth: 3)
        )
    }
}

#Preview {
    TrainingTimeCardView(image: "freediver-1", title: "Personal Best", subTitle: "Breath Hold", time: "2:42")
}
