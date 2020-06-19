//
//  PulsateView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 17/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct PulsateView: View {
    @EnvironmentObject var settingsStore:SettingsStore
    @State private var show = false
    var delay: Double
    var body: some View {
        Circle()
            .frame(width: 1, height: 1)
            .foregroundColor(settingsStore.themeColor)
            .opacity(show ? 0 : 0.05)
            .scaleEffect(show ? 1000 : 1)
            .animation(Animation.easeInOut(duration: 1))
            .onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + self.delay) {
                    self.show = true
                  
                }       
        }
    }
}


