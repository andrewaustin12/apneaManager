//
//  HistoryChartView.swift
//  ApneaManager
//
//  Created by andrew austin on 1/8/24.
//

import SwiftUI
import Charts

struct HistoryChartView: View {
    @State private var sessions: [Session] = []

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

    

    var body: some View {
        Text("Charts here")
//        Chart {
//            ForEach(sessions, id: \.date) { session in
//                LineMark(
//                    x: .value("Date", entry.date),
//                    y: .value("Duration", entry.duration)
//                )
//                .interpolationMethod(.catmullRom) // Smooths the line
//                //.symbol(Circle().strokeBorder().foregroundColor(.blue)) // Data point markers
//            }
//        }
//        .chartXAxis {
//            AxisMarks(preset: .aligned, position: .bottom, values: .stride(by: Calendar.Component.day)) {
//                AxisGridLine()
//                AxisTick()
//                AxisValueLabel(format: .dateTime)
//            }
//        }
//        .chartYAxis {
//            AxisMarks(preset: .aligned) {
//                AxisGridLine()
//                AxisTick()
//                AxisValueLabel()
//            }
//        }
//        .frame(width: 300, height: 200)
  }
}

#Preview {
    HistoryChartView()
}

//sessions: [
//    Session(image: "freediver-2", title: "Session 1", subTitle: "Sub 1", date: Date.now, duration: 30),
//    Session(image: "freediver-2", title: "Session 2", subTitle: "Sub 2", date: Date.now, duration: 45),
//    Session(image: "freediver-2", title: "Session 3", subTitle: "Sub 3", date: Date.now, duration: 115),
//    Session(image: "freediver-2", title: "Session 1", subTitle: "Sub 1", date: Date.now, duration: 130),
//    Session(image: "freediver-2", title: "Session 2", subTitle: "Sub 2", date: Date.now, duration: 145),
//    Session(image: "freediver-2", title: "Session 3", subTitle: "Sub 3", date: Date.now, duration: 142),
//]
