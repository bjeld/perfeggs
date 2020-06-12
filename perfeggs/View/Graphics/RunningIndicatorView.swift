//
//  RunningIndicatorView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 12/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct RunningIndicatorView: View {
    
    var themeColor: Color
    @Binding var show: Bool
    @Binding var running: Bool
    
    var body: some View {
        ZStack {
            Circle()
              .trim(from: show ? 0.2 : 0 , to: show ? 0.3 : 0)
              .stroke(themeColor, style: StrokeStyle(lineWidth: 5, lineCap: .square, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
              .opacity(show ? 0.5 : 0)
              .frame(width: 258, height: 258)
              .rotationEffect(.degrees(show ? 180 : -180))
              .animation(Animation.easeInOut(duration: 1.8).delay(0.3))
           
           Circle()
              .trim(from: show ? 0.2 : 0 , to: show ? 0.4 : 0)
              .stroke(themeColor, style: StrokeStyle(lineWidth: 5, lineCap: .square, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
              .opacity(show ? 0.5 : 0)
              .frame(width: 258, height: 258)
              .rotationEffect(.degrees(show ? 342 : 0))
              .animation(Animation.easeInOut(duration: 1.8).delay(0.4))
        }
    }
}

struct RunningIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        RunningIndicatorView(themeColor: Color.pink, show: .constant(true), running: .constant(false))
    }
}
