//
//  SessionHistoryDetailView.swift
//  ApneaManager
//
//  Created by andrew austin on 2/8/24.
//

import SwiftUI

struct SessionHistoryDetailView: View {
    var session: Session

    var body: some View {
        List {
            
            Section(header: Text("Session Overview")) {
                HStack {
                    Label("Type", systemImage: "waveform.path.ecg")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(session.sessionType.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Label("Duration", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text("\(formattedTime(seconds: session.duration)) ")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                
                HStack {
                    Label("Date", systemImage: "calendar")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(formattedDate(session.date))
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
            
            if let tableData = session.tableData, let cycles = decodedTableData(tableData), !cycles.isEmpty {
                Section(header: Text("Table Details")) {
                    ForEach(Array(cycles.enumerated()), id: \.element.id) { (index, cycle) in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Round \(index + 1)") // index is 0-based; add 1 to start from Round 1
                                .font(.title3)
                                .bold()
                                .foregroundColor(.primary)

                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Apnea")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("\(formattedTime(seconds:cycle.hold))") // Added "seconds" for clarity
                                        .font(.subheadline)
                                }

                                Spacer()

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Breathe")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                    Text("\(formattedTime(seconds: cycle.rest))")
                                        .font(.subheadline)
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        
                        
                    }
                }
            }

        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Session Detail")
        .navigationBarTitleDisplayMode(.inline)
    }

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formattedTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60

        if minutes > 0 && remainingSeconds == 0 {
            // When the duration is exactly on a minute mark, e.g., 1m, 2m, etc.
            return "\(minutes) min"
        } else if minutes > 0 {
            // When the duration includes both minutes and seconds, e.g., 1m 30s, 2m 15s, etc.
            return "\(minutes) min \(remainingSeconds) sec"
        } else {
            // When the duration is less than a minute, e.g., 30s, 45s, etc.
            return "\(remainingSeconds) sec"
        }
    }


    func decodedTableData(_ jsonData: String) -> [Cycle]? {
        guard let data = jsonData.data(using: .utf8) else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode([Cycle].self, from: data)
    }
}


struct SessionHistoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Sample O2 table data
        let sampleCycles = [
            Cycle(hold: 30, rest: 60),
            Cycle(hold: 35, rest: 60),
            Cycle(hold: 40, rest: 60)
        ]
        
        // Serialize the sampleCycles to JSON
        let jsonData = try! JSONEncoder().encode(sampleCycles)
        let jsonTableData = String(data: jsonData, encoding: .utf8)!
        
        // Create a sample session with the serialized O2 table data
        let sampleSession = Session(
            id: UUID(),
            date: Date(),
            image: "freediver-3",
            sessionType: .O2Table, // Use the O2Table case for sessionType
            duration: 120,
            tableData: jsonTableData // Include the serialized O2 table data
        )
        
        SessionHistoryDetailView(session: sampleSession)
    }
}

