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
    @State private var show = false
    
    var body: some View {
        
        ZStack {
            // WatchView(progress: CGFloat(countdown.progess) * 100, themeColor: settingStore.themeColor)
            ArcView(show: self.$show, running: self.$countdown.running, themeColor: settingStore.themeColor)
            RunningIndicatorView(themeColor: settingStore.themeColor, show: self.$show, running: self.$countdown.running)
           
            if self.show {
            ProgressCircleView(progress: CGFloat(countdown.progess), color: settingStore.themeColor)
                .transition(AnyTransition.scaleAndFade(delay: 0.5))
            }
            
            
               if self.show {
            TitleView(firstText: "Boil time", lastText: self.viewState.getEggBoilLabel(), themeColor: settingStore.themeColor ).offset(x: 0, y: -240)
                .transition(AnyTransition.scaleAndFade(delay: 1.5))
                }
            
            // PLAY BUTTON
            if !self.countdown.running {
                if self.show {
                    
                
                Button(action: {
                    self.countdown.start()
                    TextToSpeak.shared.speakTimerStarted()
                }) {
                    PlayButtonView(themeColor: settingStore.themeColor)
                }
                .opacity(self.countdown.running ? 0 : 1)
                .transition(AnyTransition.scaleAndFade(delay: 0.6))
                    }
            }
            
            // STOP BUTTON
             if self.show {
            Button(action: {
                if self.countdown.running {
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
                 .transition(AnyTransition.scaleAndFade(delay: 0.9))
              }
            
            if self.countdown.running {
                
                Text("\(Int(countdown.progess*100))%")
                    .foregroundColor(settingStore.themeColor)
                    .bold()
            }
            
            Image(getEggImage())
                .resizable()
                .frame(width: 37, height: 50)
                .opacity(self.countdown.finished ? 1 : 0)
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
            
            self.show = true
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
