//
//  TitleView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 16/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    var firstText: String
    var lastText: String
    var themeColor: Color
    
    var body: some View {
        HStack {
            Text(firstText)
                .font(.subheadline)
                .foregroundColor(themeColor)
                .bold()
    
    
            Rectangle().frame(width: 1, height: 12).foregroundColor(.white).opacity(0.25)
            Text(lastText)
                .font(.subheadline)
                .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
    
    
        }
        
    }
}



