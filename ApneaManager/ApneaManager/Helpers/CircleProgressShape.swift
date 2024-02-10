//
//  CircleProgressShape.swift
//  ApneaManager
//
//  Created by andrew austin on 1/9/24.
//

import SwiftUI

struct CircleProgressShape: Shape {
    var progress: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: Angle(degrees: -90),
                    endAngle: Angle(degrees: -90 + Double(progress * 360)),
                    clockwise: false)
        return path
    }
}

//struct CircleProgressShape: Shape {
//    var progress: CGFloat
//
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: .degrees(-90), endAngle: .degrees(-90 + 360 * progress), clockwise: false)
//        return path
//    }
//}
