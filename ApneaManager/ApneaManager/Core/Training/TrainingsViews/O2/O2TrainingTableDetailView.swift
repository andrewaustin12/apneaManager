//
//  O2TrainingTableDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/31/24.
//

import SwiftUI

struct O2TrainingTableDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    var o2Table: [(hold: Int, rest: Int)]

    var body: some View {
        NavigationView {
            List(o2Table.indices, id: \.self) { index in
                VStack(alignment: .leading, spacing: 4) {
                    Text("Round \(index + 1)")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Apnea")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(formattedTime(seconds: o2Table[index].hold))")
                                .font(.headline)
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Breathe")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text("\(formattedTime(seconds: o2Table[index].rest))")
                                .font(.headline)
                        }
                    }
                    //.padding(8)
                    .background(Color(.systemBackground))
                    .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .background(Color(.systemBackground))
            }
            .listStyle(.plain)
            .navigationTitle("O2 Training Table")
            .toolbar{
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
                .position(x: 16, y: 16)
            }
        }
    }
    
    private func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        if minutes > 0 && remainingSeconds == 0 {
            // When the duration is exactly on a minute mark, e.g., 1m, 2m, etc.
            return "\(minutes)m"
        } else if minutes > 0 {
            // When the duration includes both minutes and seconds, e.g., 1m 30s, 2m 15s, etc.
            return "\(minutes)m \(remainingSeconds)s"
        } else {
            // When the duration is less than a minute, e.g., 30s, 45s, etc.
            return "\(remainingSeconds)s"
        }
    }

}

#Preview {
    O2TrainingTableDetailView(o2Table: [(hold: 30, rest: 60), (hold: 30, rest: 55), (hold: 30, rest: 50)])
}
