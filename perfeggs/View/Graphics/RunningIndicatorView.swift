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
                  .trim(from: 0.2, to: 0.3)
                  .stroke(themeColor, lineWidth: 5)
                  .opacity(0.8)
                  .rotationEffect(.degrees(90))
                  .frame(width: 250, height: 250)
                  .transition(AnyTransition.scaleAndFade(delay: 0.4))
                  .rotation3DEffect(.degrees(running ? 360 : 0), axis: (x: 0, y: 0, z: 1))
                  .animation(running ? Animation.easeInOut(duration: 4).repeatForever(autoreverses: false) : .default)
             
              // Running inicator 2.2
              Circle()
                  .trim(from: 0.2, to: 0.3)
                  .stroke(themeColor, lineWidth: 5)
                  .opacity(0.8)
                  .rotationEffect(.degrees(-90))
                  .frame(width: 250, height: 250)
                  .transition(AnyTransition.scaleAndFade(delay: 0.5))
                  .rotation3DEffect(.degrees(running ? 360 : 0), axis: (x: 0, y: 0, z: 1))
                  .animation(running ? Animation.easeInOut(duration: 4).repeatForever(autoreverses: false) : .default)
        }
    }
}

struct RunningIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        RunningIndicatorView(themeColor: Color.pink, show: .constant(true), running: .constant(false))
    }
}
