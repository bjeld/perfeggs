//
//  StopButtonView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 28/05/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct StopButtonView: View {
    
    var themeColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(themeColor, style: StrokeStyle(lineWidth: 1))
                .frame(width: 60, height: 60)
                .opacity(0.5)
            Image(systemName: "xmark")
                .foregroundColor(themeColor)
                .font(.system(size: 24))
        }
    }
}

struct StopButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StopButtonView(themeColor: Color.red)
    }
}
