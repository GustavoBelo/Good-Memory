//
//  Pie.swift
//  Good Memory
//
//  Created by Gustavo Belo on 20/03/21.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = true
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height)/2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radius)),
            y: center.y + radius * sin(CGFloat(startAngle.radius))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        p.addLine(to: center)
        return p
    }
}
