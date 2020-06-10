//
//  ArcView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct ArcView: View {
    
    // LOCAL STATE
    @Binding var show:Bool
    
    var themeColor: Color
  
    // UI
    var body: some View {
        ZStack {
            Ticks()
                .frame(width: show ? 130 : 0, height: show ? 130: 0)
                .foregroundColor(themeColor)
                .opacity(show ? 0.4 : 0)
                .animation(Animation.spring().delay(0.2))
            
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: 40))
                .opacity(show ? 0.05 : 0)
                .frame(width: show ? 214 : 0, height: show ? 214 : 0)
                .animation(Animation.spring().delay(0.3))
            
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: 1))
                .opacity(show ? 0.25 : 0)
                .frame(width: show ? 156 : 0, height: show ? 156 : 0)
                .animation(Animation.spring().delay(0.4))
            
            
                
            Image("egg")
                .resizable()
                .frame(width: 37, height: 50)
                .opacity(show ? 0.75 : 0)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(2))
            
            
        }.edgesIgnoringSafeArea(.all)
    }
}

struct ArcView_Previews: PreviewProvider {
   
    
    struct TextArcView: View {
        @State var show = true
        var body: some View {
            ArcView(show: self.$show, themeColor: Color.red)
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
