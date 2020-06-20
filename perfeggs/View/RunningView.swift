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
            
            
            Color.white.opacity(self.countdown.finished ? 0.10 : 0)
                .animation(self.countdown.finished ? Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true) : .default)
            
            if !self.countdown.finished {
                ArcView(show: self.$show, running: self.$countdown.running, themeColor: settingStore.themeColor)
            }
            
           
            if self.show && !self.countdown.finished {
                RunningIndicatorView(themeColor: settingStore.themeColor, show: self.$show, running: self.$countdown.running)
                    .transition(AnyTransition.scaleAndFade(delay: 0.7))
            }
            
            if self.show && !self.countdown.finished {
                ProgressCircleView(progress: CGFloat(countdown.progess), color: settingStore.themeColor)
                    .transition(AnyTransition.scaleAndFade(delay: 0.5))
            }
            
            if self.show && !self.countdown.finished {
                TitleView(firstText: "Boil time", lastText: self.viewState.getEggBoilLabel(), themeColor: settingStore.themeColor )
                    .offset(x: 0, y: -240)
                    .transition(AnyTransition.opacity.animation(Animation.easeInOut(duration: 0.5).delay(0.5)))
                   
            }
            
            // PLAY BUTTON
            if !self.countdown.running && !self.countdown.finished {
                if self.show {
                    Button(action: {
                        self.countdown.start()
                        TextToSpeak.shared.speakTimerStarted()
                    }) {
                        PlayButtonView(themeColor: settingStore.themeColor)
                    }
                    .transition(AnyTransition.scaleAndFade(delay: 0.6))
                }
            }
            
            // STOP BUTTON
            if self.show && !self.countdown.finished {
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
            
            if self.show && !self.countdown.finished && self.countdown.running {
                Image(getEggImage())
                   .resizable()
                   .frame(width: 37, height: 50)
                   .opacity(0.75)
                   .transition(AnyTransition.scaleAndFade(delay: 0.4))
            }
            
            
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
            ActionSheet(title: Text("Do you want to cancel the timer"), buttons: [.default(Text("No, continue")), .destructive(Text("Yes, cancel timer")) {
                self.countdown.stop()
                self.viewState.currentView = .idle
                }])
        }
        .onTapGesture {
            if self.countdown.finished {
                self.countdown.finished = false
                self.viewState.currentView = .idle
            }
        }
        
    }
    
    private func getEggImage() -> String {
        
        switch self.viewState.eggBoil {
        case .verySoft:
            return "finished_very_soft"
        case .soft:
            return "finished_soft"
        case .medium:
            return "finished_medium"
        case .hard:
            return "finished_hard"
        }
        
    }
    
    
}
/*
 if self.countdown.running {
 Text("\(Int(countdown.progess*100))%")
 .foregroundColor(settingStore.themeColor)
 .bold()
 }
 */
