//
//  BreathHoldHeader.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//

import SwiftUI

struct BreathHoldHeader: View {
    let secondsElapsed: Int
    let theme: Theme
    let personalBestSeconds: Int

    
    private var progress: Double {
        guard personalBestSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(personalBestSeconds)  // Use personal best time here
    }
    private var secondsRemaining: Int {
        personalBestSeconds - secondsElapsed
    }
    
    var body: some View {
        NavigationStack {
            
            ProgressView(value: progress)
                .progressViewStyle(TrainingProgressViewStyle(theme: theme))
//                .overlay {
//                    Text("\(secondsElapsed) / \(personalBestSeconds) seconds")  // Display elapsed vs. personal best
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
            HStack {
                VStack(alignment: .leading) {
                    Text("Seconds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Personal Best")
                        .font(.caption)
                    Label("\(personalBestSeconds)", systemImage: "trophy")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.horizontal])
    }
}


#Preview {
    BreathHoldHeader(secondsElapsed: 25, theme: .bubblegum, personalBestSeconds: 65)
}
