//
//  DotsView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 20/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct DotsView: View {
    
    var themeColor: Color
    
    var body: some View {
        ZStack {
            GeometryReader { (geometry) in
                self.makeView(geometry)
            }
        }.edgesIgnoringSafeArea(.all)
        
    }
    
    func makeView(_ geometry: GeometryProxy) -> some View {
        
        let size = geometry.size.width / 13
        let rows = Int(geometry.size.height / size) + 1;
        
        
        let extra = (size * CGFloat(rows)) - geometry.size.height
        
        return GridStack(rows: rows, columns: 13) { row, col in
            SquareDot(themeColor: self.themeColor)
                .frame(width: size, height: size)
        }.offset(x: 0, y: -(extra/2))
    }
}

struct DotsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            DotsView(themeColor: Color.red)
        }.edgesIgnoringSafeArea(.all)
        
    }
    
}
