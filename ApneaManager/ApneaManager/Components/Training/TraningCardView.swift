

import SwiftUI

struct TrainingCardView: View {
    // Assuming `image` is the name of the image in the asset catalog
    let image: String
    let title: String
    let subHeading: String
    let description: String
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            // Image on the left
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                //.padding(.leading, 10)
            
            // Text content on the right
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.primary)
                
                Text(subHeading)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(description)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                //.lineLimit(2) // Limit to two lines for succinctness
            }
            .padding(.trailing, 10)
            
            Spacer()
        }
        .frame(width: 350, height: 200)
        .background(Color(UIColor.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .shadow(color: colorScheme == .light ? Color.black.opacity(0.3) : Color.white.opacity(0.3), radius: 5, x: 0, y: 2)
        .padding(10)
    }
}

// Preview provider adjusted to the corrected struct name
#Preview {
    TrainingCardView(image: "freediver-1", title: "CO2 Training", subHeading: "4 CYCLES | TIME - 2:00", description: "Pre-breathing involves controlled breathing exercises to balance oxygen and carbon dioxide levels")
}

////  CardView.swift
////  ApneaManager
////
////  Created by andrew austin on 1/5/24.
////
//
//import SwiftUI
//
//struct TraningCardView: View {
//    let image: String
//    let title: String
//    let subHeading: String
//    let description: String
//
//    var body: some View {
//        ZStack(alignment: .bottomLeading) {
//            Image(image)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 320, height: 200)
//                .clipShape(RoundedRectangle(cornerRadius: 20))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 20) // Apply the corner radius to the overlay as well.
//                        .stroke(Color.gray, lineWidth: 2)
//                )
//
//
//            VStack(alignment: .leading, spacing: 6) {
//                Text(title)
//                    .font(.title)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                Text(subHeading)
//                    .font(.subheadline)
//                    .bold()
//                    .foregroundColor(.white)
//
//                Text(description)
//                    .font(.caption)
//                    .bold()
//                    .foregroundColor(.white)
//                    .lineLimit(2)
//            }
//            .padding()
//        }
//        .frame(width: 320, height: 200)
//        .background(Color.black.opacity(0.7))
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//    }
//}
//
//#Preview {
//    TraningCardView(image: "freediver-1", title: "CO2 Training", subHeading: "4 CYCLES | TIME - 2:00", description: "Pre-breathing involves controlled breathing exercises to balance oxygen and carbon dioxide levels")
//}
