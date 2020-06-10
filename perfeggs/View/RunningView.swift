//
//  RunningView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct RunningView: View {
    @EnvironmentObject var viewState:ViewState
    @EnvironmentObject var countdown:Countdown
    @EnvironmentObject var settingStore:SettingsStore
    
    @State private var showingAlert = false
    
    var body: some View {
        
        ZStack {
            WatchView(progress: CGFloat(countdown.progess) * 100, themeColor: settingStore.themeColor)
            
            TitleView(firstText: "Boil time", lastText: self.viewState.getEggBoilLabel(), themeColor: settingStore.themeColor ).offset(x: 0, y: -240)
            
            // PLAY BUTTON
            if self.countdown.mode == .stopped {
                Button(action: {
                    self.countdown.start()
                    TextToSpeak.shared.speakTimerStarted()
                }) {
                    PlayButtonView(themeColor: settingStore.themeColor)
                }
                .opacity(self.countdown.mode == .running ? 0 : 1)
            }
            
            // STOP BUTTON
            
            Button(action: {
                if self.countdown.mode == .running {
                    self.showingAlert = true
                }
                else {
                    self.countdown.stop()
                    self.viewState.currentView = .idle
                }
            }) {
                StopButtonView(themeColor: settingStore.themeColor)
            }
            .offset(x: 0, y: 240)
            
            
            if self.countdown.mode == .running {
                Text("\(Int(countdown.progess*100))%")
                    .foregroundColor(settingStore.themeColor)
                    .bold()
            }
            
            Image(getEggImage())
                .resizable()
                .frame(width: 37, height: 50)
                .opacity(self.countdown.mode == .finished ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true).delay(2))
            
        }
        .onAppear() {
            // Keeps the app from going into background idle mode
            UIApplication.shared.isIdleTimerDisabled = true
            
            var extraTime = 0
            if self.settingStore.eggStorageMode == .fridge {
                extraTime = 20
                print("Adding \(extraTime) extra time because eggs are stored in the fridge")
            }
            
            self.countdown.setup(eggBoilTimeInSeconds: self.viewState.getTimeToCook() + extraTime)
            
            TextToSpeak.shared.speakPutEggsInBoilingWater()
        }
        .actionSheet(isPresented: $showingAlert) {
            ActionSheet(title: Text("Do you want to cancel the timer"), buttons: [.cancel(Text("No, continue")), .destructive(Text("Yes, cancel timer")) {
                self.countdown.stop()
                self.viewState.currentView = .idle
                }])
        }
        
    }
    
    private func getEggImage() -> String {
        switch self.viewState.eggBoil {
        case .verySoft:
            return "extra_soft"
        case .soft:
            return "soft"
        case .medium:
            return "medium"
        case .hard:
            return "hard"
        }
        
    }
    
    
}
