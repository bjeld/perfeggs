//
//  WatchView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 30/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct Tick: Shape {
    var isLong: Bool = true
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + 10))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + 15 + (isLong ? 5 : 0)))
        return path
    }
    
}

struct Ticks: View {
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            ForEach(0..<60) { position in
                Tick()
                    .stroke(lineWidth: 1)
                    .rotationEffect(.radians(Double.pi*2 / 60 * Double(position)))
            }
        }
    }
}

struct WatchView: View {
    
    @State var spin = false
    @State var show = false
    
    var progress:CGFloat = 0
    var themeColor: Color
    
    var body: some View {
        ZStack {
            Ticks()
                .frame(width: 130,height: 130)
                .foregroundColor(themeColor)
                .opacity(show ? 0.4 : 0)
                .animation(Animation.spring().delay(0.2))
                .rotationEffect(.degrees(spin ? -360 : 0))
                .animation(Animation.linear(duration: 60).repeatForever(autoreverses: false))
                .onAppear() {
                    self.spin.toggle()
            }
            
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: 40))
                .opacity(show ? 0.05 : 0.0)
                .frame(width: show ? 214 : 0, height: show ? 214 : 0)
                .animation(Animation.spring().delay(0.3))
            
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: 40))
                .opacity(show ? 0.15 : 0.0)
                .frame(width: 214, height: 214)
                .animation(Animation.easeInOut(duration: 1.8).delay(0.3).repeatForever(autoreverses: true))
            
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: show ? 5 : 1))
                .opacity(show ? 0.15 : 0)
                .frame(width: show ? 156 : 0, height: show ? 156 : 0)
                .animation(Animation.spring().delay(0.4))
            
            CircleView(progress: (100-progress)/100, color: themeColor)
                .frame(width: 156, height: 156)
            
            Circle()
                .trim(from: 0.2 , to: 0.3 )
                .stroke(themeColor, style: StrokeStyle(lineWidth: 5, lineCap: .square, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .frame(width: 258, height: 258)
                .rotationEffect(.degrees(show ? 360 : 0))
                .animation(Animation.easeInOut(duration: 2.8).repeatForever(autoreverses: false).delay(0.3))
            
            Circle()
                .trim(from: 0.2 , to:  0.3)
                .stroke(themeColor, style: StrokeStyle(lineWidth: 5, lineCap: .square, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0))
                .frame(width: 258, height: 258)
                .rotationEffect(.degrees(show ? 180 : -180))
                .animation(Animation.easeInOut(duration: 2.8).repeatForever(autoreverses: false).delay(0.3))
            
          
            
        }.edgesIgnoringSafeArea(.all).onAppear() {
            self.show.toggle()
        }
        
        
    }
}

struct WatchView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            DotsView(themeColor: Color.red)
            WatchView(themeColor: Color.red)
        }.edgesIgnoringSafeArea(.all)
    }
}
