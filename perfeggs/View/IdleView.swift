//
//  MeasureEggView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct IdleView: View {
    
    @EnvironmentObject var viewState:ViewState
    @EnvironmentObject var settingsStore:SettingsStore
    
    var targetCount = 50
    var isTimerRunning = false
    let timer = Timer.publish(every: 0.1, tolerance: 0.1, on: .main, in: .common).autoconnect()
    
    @State private var counter = 0
    @State private var forceValue:CGFloat = 0
    @State private var endValue:CGFloat = 0
    @State private var isWeighingCompleted:Bool = false
    @State private var show:Bool = false
    
    var body: some View {
        ZStack {
            ForceAnimationView(themeColor: settingsStore.themeColor, forceValue: self.$forceValue)
            ArcView(show:self.$show, themeColor: settingsStore.themeColor)
            
            GeometryReader { g in
                EggsViewController(forceValue: self.$forceValue ).frame(width: g.size.width, height: g.size.height / 2)
            }
        }
        
        .animation(.default)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                Audio.shared.playUITransition()
            }
            
            self.show = true
            TextToSpeak.shared.speakPutEggOnScreen()
            Audio.shared.playMusicSoundLoop()
        }
        .onReceive(timer) { (time) in
            // If we are not showing the grahical animations yet the we should not tick the count
            if !self.show {
                return
            }
            
            // Only if wheighing is NOT completed we want to tick the counter
            if !self.isWeighingCompleted {
                
                if self.counter == 2 {
                    TextToSpeak.shared.speakScanning()
                }
                
                // A force was detected (the egg)
                if self.forceValue > 0.1 {
                    self.counter += 1
                }
                    // Reset tick counter when still wheighing but egg was removed before wheighing completed
                else if self.counter != 0 {
                    self.counter = 0
                }
            }
            
            // Tick counter completed
            if self.counter == self.targetCount && !self.isWeighingCompleted {
                self.endValue = self.forceValue
                self.isWeighingCompleted = true
                
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
                
                switch self.endValue {
                case 0.1...0.8:
                    TextToSpeak.shared.speakSmallEggSize()
                case 0.8...0.85:
                    TextToSpeak.shared.speakMediumEggSize()
                case 0.85...0.87:
                    TextToSpeak.shared.speakLargeEggSize()
                case 0.87...2:
                    TextToSpeak.shared.speakExtraLargeEggSize()
                default:
                    TextToSpeak.shared.speakMediumEggSize()
                }
            }
            
            // Weighing was completed, and egg was removed
            if self.isWeighingCompleted && self.forceValue < 0.1 {
                self.show = false
                
                // make time for the hide graphical animation to complete before transitioning to next screen
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.timer.upstream.connect().cancel()
                    self.viewState.setWeightValue(value: self.endValue)
                    
                    if self.settingsStore.eggBoilMode == .choose {
                        self.viewState.currentView = ViewStateEnum.choose
                    }
                    else {
                        
                        switch self.settingsStore.eggBoilMode {
                            
                        case .skipToHardBoiled:
                            self.viewState.eggBoil = .hard
                            
                        case .skipToMediumBoiled:
                            self.viewState.eggBoil = .medium
                            
                        case .skipToSoftBoiled:
                            self.viewState.eggBoil = .soft
                            
                        case .skipToVerySoftBoiled:
                            self.viewState.eggBoil = .verySoft
                            
                        default:
                            self.viewState.eggBoil = .soft
                        }
                        
                        self.viewState.currentView = .running
                        
                    }
                    
                }
            }
            
        }
    }
}

struct IdleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            DotsView(themeColor: Color.red)
            IdleView()
        }.edgesIgnoringSafeArea(.all)
    }
}
