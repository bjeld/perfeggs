//
//  ArcView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static func scaleAndFade(delay: Double = 0) -> AnyTransition {
        
        let insertion = AnyTransition.scale.combined(with: .opacity)
            .animation(Animation.spring(response: 0.6, dampingFraction: 0.5)
                .speed(1.2)
                .delay(delay))
        let removal = AnyTransition.scale.combined(with: .opacity)
            .animation(Animation.spring(response: 0.6, dampingFraction: 0.5).speed(1.2))
        
        return .asymmetric(insertion: insertion, removal: removal)
    }
}


struct ArcView: View {
    
    // LOCAL STATE
    @Binding var show:Bool
    @Binding var running:Bool
    
    var themeColor: Color
    
    // UI
    var body: some View {
        ZStack {
            
            if show {
                
                TicksView()
                    .foregroundColor(themeColor)
                    .opacity(0.4)
                    .frame(width: 130, height: 130)
                    .transition(AnyTransition.scaleAndFade(delay: 0.1))
                
                Circle()
                    .stroke(themeColor, style: StrokeStyle(lineWidth: 40))
                    .opacity(0.05)
                    .frame(width: 214, height: 214)
                    .transition(AnyTransition.scaleAndFade(delay: 0.2))
                
                Circle()
                    .stroke(themeColor, style: StrokeStyle(lineWidth: 1))
                    .opacity(0.25)
                    .frame(width: 156, height: 156)
                    .transition(AnyTransition.scaleAndFade(delay: 0.3))
               
            }
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ArcView_Previews: PreviewProvider {
    
    
    struct TextArcView: View {
        @State var show = true
        @State var running = false
        var body: some View {
            ArcView(show: self.$show, running: self.$running, themeColor: Color.red)
        }
    }
    
    
    
    static var previews: some View {
        ZStack{
            BackgroundView().edgesIgnoringSafeArea(.all)
            DotsView(themeColor: Color.red)
            TextArcView()
        }
    }
}
