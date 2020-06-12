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
