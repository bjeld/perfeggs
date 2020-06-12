//
//  ContentView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 16/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var viewState:ViewState
    @EnvironmentObject var settingsStore:SettingsStore
    
    var body: some View {
        ZStack {
            BackgroundView()
            DotsView(themeColor: settingsStore.themeColor)
            
            if viewState.currentView == .idle {
                IdleView()
            }
            
            if viewState.currentView == .choose {
                ChooseView()
            }
            
            if viewState.currentView == .running {
                RunningView()
            }
            
            SettingsTriggerView()
        }
        .onAppear() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge,.sound,.alert]) { (_, _) in }
        }
        .edgesIgnoringSafeArea(.all)
        .prefersHomeIndicatorAutoHidden(true)
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

