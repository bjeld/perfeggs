//
//  ForceAnimationView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 02/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct ForceAnimationView: View {
    
    var themeColor: Color
    
    @Binding var forceValue:CGFloat
    
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(themeColor)
                .opacity(0.05)
                .scaleEffect(x:forceValue*1.8, y: forceValue*1.8)
                .animation(.spring())
            
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
            
        }.onAppear() {
            withAnimation() {
                self.show = true
            }
        }
    }
}

struct ForceAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        ForceAnimationView(themeColor: Color.blue, forceValue: .constant(0.4))
    }
}
