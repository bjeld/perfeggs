//
//  BackgroundView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 20/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        
            LinearGradient(gradient: Gradient(colors: [
            Color(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)),
            Color(#colorLiteral(red: 0.06131701916, green: 0.08687037975, blue: 0.1036673412, alpha: 1))]), startPoint: .bottomTrailing, endPoint: .topLeading)
        
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView().edgesIgnoringSafeArea(.all)
    }
}


/*
 RadialGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.03504931554, green: 0.04370009154, blue: 0.06129845232, alpha: 1)),
                                                Color(#colorLiteral(red: 0.06108892709, green: 0.08661425859, blue: 0.1095703617, alpha: 1))]), center: .center, startRadius: 25, endRadius: 900)
 
 
 
 */
