//
//  ProgressViewStyle.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct TrainingProgressViewStyle: ProgressViewStyle {
    

    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.ultraThinMaterial)
                .frame(height: 20.0)
            if #available(iOS 15.0, *) {
                ProgressView(configuration)
                    .tint(Color.green)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            } else {
                ProgressView(configuration)
                    .frame(height: 12.0)
                    .padding(.horizontal)
            }
        }
    }
}

struct TrainingProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
            .progressViewStyle(TrainingProgressViewStyle())
            .previewLayout(.sizeThatFits)
    }
}
