//
//  TicksView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 12/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct Tick: Shape {
    var isLong: Bool = true
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY + 10))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY + 15 + (isLong ? 5 : 0)))
        return path
    }
    
}

struct Ticks: View {
    var body: some View {
        ZStack {
            ForEach(0..<60) { position in
                Tick()
                    .stroke(lineWidth: 1)
                    .rotationEffect(.radians(Double.pi*2 / 60 * Double(position)))
            }
        }
    }
}

struct TicksView: View {
    var body: some View {
        Ticks()
    }
}

struct TicksView_Previews: PreviewProvider {
    static var previews: some View {
        TicksView()
    }
}
