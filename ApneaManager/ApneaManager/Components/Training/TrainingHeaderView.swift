//
//  TrainingHeaderView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/7/24.
//
import SwiftUI

struct TrainingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme: Theme

    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    
    var body: some View {
        NavigationStack {
            ProgressView(value: progress)
                .progressViewStyle(TrainingProgressViewStyle(theme: theme))
            HStack {
                VStack(alignment: .leading) {
                    Text("Rounds Elapsed")
                        .font(.caption)
                    Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Rounds Remaining")
                        .font(.caption)
                    Label("\(secondsRemaining)", systemImage: "hourglass.bottomhalf.fill")
                        .labelStyle(.trailingIcon)
                }
            }
        }
        .padding([.top, .horizontal])
    }
}

#Preview {
    TrainingHeaderView(secondsElapsed: 1, secondsRemaining: 16, theme: .bubblegum)
}
