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
            Color(#colorLiteral(red: 0.06131701916, green: 0.08687037975, blue: 0.1036673412, alpha: 1)),
            Color(#colorLiteral(red: 0.06131701916, green: 0.08687037975, blue: 0.1036673412, alpha: 1))]), startPoint: .top, endPoint: .bottom)
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView().edgesIgnoringSafeArea(.all)
    }
}
