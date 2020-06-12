//
//  SquareDot.swift
//  perfeggs
//
//  Created by Martin Bjeld on 13/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct SquareDot: View {
    
    var themeColor: Color
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(themeColor)
                .opacity(0.25)
                .frame(width: 2, height: 2)
            
        }
    }
}

struct SquareDot_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            SquareDot(themeColor: Color.red)
        }.edgesIgnoringSafeArea(.all)
    }
}
