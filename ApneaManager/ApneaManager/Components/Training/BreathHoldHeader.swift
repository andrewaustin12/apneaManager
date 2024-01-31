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
        guard personalBestSeconds > 0 else { return 0 }
        let progressValue = Double(secondsElapsed) / Double(personalBestSeconds)
        return min(progressValue, 1)  // Ensure progress does not exceed 1
    }
    private var secondsRemaining: Int {
        personalBestSeconds - secondsElapsed
    }
    
    var body: some View {
        NavigationStack {
            
            ProgressView(value: progress)
                .progressViewStyle(TrainingProgressViewStyle())
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
                    Label(timeString(from: CGFloat(personalBestSeconds)), systemImage: "trophy")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.horizontal])
    }
    private func timeString(from totalSeconds: CGFloat) -> String {
        let minutes = Int(totalSeconds) / 60
        let seconds = Int(totalSeconds) % 60

        if minutes == 0 {
            // For durations less than a minute, display in seconds format (e.g., "7s")
            return "\(seconds)s"
        } else {
            // For durations a minute or longer, display in minute:second format (e.g., "1:01")
            return String(format: "%d:%02d", minutes, seconds)
        }
    }

}


#Preview {
    BreathHoldHeader(secondsElapsed: 25, theme: .bubblegum, personalBestSeconds: 65)
}
