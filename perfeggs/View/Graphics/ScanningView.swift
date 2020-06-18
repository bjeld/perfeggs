//
//  ScanningView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 17/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct ScanningView: View {
        // LOCAL STATE
       @Binding var show:Bool
       @Binding var running:Bool
       
       var themeColor: Color
       
       // UI
       var body: some View {
           ZStack {
               
               if show {
                  
                    Circle()
                       .stroke(themeColor, style: StrokeStyle(lineWidth: 40))
                       .opacity(0.15)
                       .frame(width: 214, height: 214)
                       .transition(AnyTransition.scaleAndFade(delay: 0.2))
                   
                   Circle()
                       .stroke(themeColor, style: StrokeStyle(lineWidth: 1))
                       .opacity(0.25)
                       .frame(width: 156, height: 156)
                       .transition(AnyTransition.scaleAndFade(delay: 0.3))
                  
                    ProgressCircleView(progress: 0, color: themeColor)
                        .transition(AnyTransition.scaleAndFade(delay: 0.5))
               }
               
               
           }.edgesIgnoringSafeArea(.all)
       }
}
