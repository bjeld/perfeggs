//
//  SettingsTriggerView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 09/06/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct SettingsTriggerView: View {
    @State var showSettings = false
    @EnvironmentObject var settingsStore:SettingsStore
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            HStack {
                Spacer().frame(width: 25)
                Button(action: {
                    self.showSettings = true
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(settingsStore.themeColor)
                            .opacity(0.03)
                        Image(systemName: "gear")
                            .foregroundColor(settingsStore.themeColor)
                            .font(.system(size: 24))
                            .opacity(0.5)
                    }
                }
               Spacer()
            }
            Spacer()
        }.sheet(isPresented: self.$showSettings, content: {
            SettingsView(isPresented: self.$showSettings).environmentObject(self.settingsStore)
        })
    }
}


struct SettingsTriggerView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTriggerView()
    }
}


/*
 Spacer()
                Button(action: {
                    Audio.shared.toggleMusicVolume()
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(settingsStore.themeColor)
                            .opacity(0.03)
                        Image(systemName: "music.note")
                            .foregroundColor(settingsStore.themeColor)
                            .font(.system(size: 24))
                            .opacity(0.5)
                    }
                }
                Spacer().frame(width: 25)
 */
