//
//  PlayButtonView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 28/05/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct PlayButtonView: View {
    
    var themeColor: Color
    
    var body: some View {
        ZStack {
            Circle().frame(width: 80, height: 80).foregroundColor(themeColor)
            Image(systemName: "play.fill").foregroundColor(Color(#colorLiteral(red: 0.06131701916, green: 0.08687037975, blue: 0.1036673412, alpha: 1))).font(.system(size: 24))
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView(themeColor: Color.red)
    }
}
