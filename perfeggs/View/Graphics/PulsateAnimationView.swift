//
//  PulsateAnimationView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 17/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct PulsateAnimationView: View {
    
    @State private var showPulsate = false
    
    let timer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if showPulsate {
                
                PulsateMultipleView().onAppear() {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
                
            }
        }
        .onReceive(timer) { time in
            self.showPulsate.toggle()
            
        }
        .onAppear() {
            self.showPulsate = true
        }
    }
}
