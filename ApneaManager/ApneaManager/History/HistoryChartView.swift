//
//  HistoryChartView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI
import Charts

struct HistoryChartView: View {
    var sessionHistory: [SessionHistory]

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    

    var body: some View {
        Chart {
            ForEach(sessionHistory, id: \.date) { entry in
                LineMark(
                    x: .value("Date", entry.date),
                    y: .value("Duration", entry.duration)
                )
                .interpolationMethod(.catmullRom) // Smooths the line
                //.symbol(Circle().strokeBorder().foregroundColor(.blue)) // Data point markers
            }
        }
        .chartXAxis {
            AxisMarks(preset: .aligned, position: .bottom, values: .stride(by: Calendar.Component.day)) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime)
            }
        }
        .chartYAxis {
            AxisMarks(preset: .aligned) {
                AxisGridLine()
                AxisTick()
                AxisValueLabel()
            }
        }
        .frame(width: 300, height: 200)
    }
}

#Preview {
    HistoryChartView(sessionHistory: [
        SessionHistory(image: "freediver-2", title: "Session 1", subTitle: "Sub 1", date: "2024-01-01", time: "12:00", duration: 30),
        SessionHistory(image: "freediver-2", title: "Session 2", subTitle: "Sub 2", date: "2024-01-02", time: "13:00", duration: 45),
        SessionHistory(image: "freediver-2", title: "Session 3", subTitle: "Sub 3", date: "2024-01-03", time: "14:00", duration: 115),
        SessionHistory(image: "freediver-2", title: "Session 1", subTitle: "Sub 1", date: "2024-01-05", time: "12:00", duration: 130),
        SessionHistory(image: "freediver-2", title: "Session 2", subTitle: "Sub 2", date: "2024-01-06", time: "13:00", duration: 145),
        SessionHistory(image: "freediver-2", title: "Session 3", subTitle: "Sub 3", date: "2024-01-07", time: "14:00", duration: 142),
    ])
}
