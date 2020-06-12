//
//  CircleView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 22/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct ProgressCircleView: View {
    
    let lineWidth:CGFloat = 3
    
    public var progress:CGFloat = 0
    public var color:Color = .black
    
    var body: some View {
        
        Circle()
            .trim(from: progress, to: 1)
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
            .animation(.linear(duration:1))
            .rotationEffect(Angle(degrees: 90))
            .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z: 0))
            .shadow(color: color.opacity(0.5), radius: 12, x: 0, y: 0)
            .frame(width: 156, height: 156)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCircleView(progress: 0.8)
    }
}
