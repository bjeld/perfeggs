//
//  PulsateMultipleView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 17/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct PulsateMultipleView: View {
    var body: some View {
        ZStack {
            PulsateView(delay: 0.1)
            PulsateView(delay: 0.3)
        }
    }
}

struct PulsateMultipleView_Previews: PreviewProvider {
    static var previews: some View {
        PulsateMultipleView()
    }
}
