//
//  ChooseView.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import SwiftUI

struct slideIn: ViewModifier {
    var delay: Double
    var duration: Double
    var opacity: Double
    var offsetY: CGFloat
    func body(content: Content) -> some View {
        content
        .opacity(opacity)
        .offset(x: 0, y: offsetY)
        .animation(Animation.easeInOut(duration: duration).delay(delay))
    }
}

struct ChooseView: View {
    
    @EnvironmentObject var viewState:ViewState
    @EnvironmentObject var settingsStore: SettingsStore
    
    
    @State var show = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 60) {
            
            //
            Button(action: {
                TextToSpeak.shared.speakExtraSoftChosen()
                self.choose(eggBoil: .verySoft)
            }) {
                TitleView(firstText: "01", lastText: "Extra Soft Boiled", themeColor: settingsStore.themeColor)
            }.modifier(slideIn(delay: 0.1, duration: 0.5, opacity: show ? 1 : 0, offsetY: show ? 0 : -50))
                
            //
            Button(action: {
                TextToSpeak.shared.speakSoftChosen()
                self.choose(eggBoil: .soft)
            }) {
                TitleView(firstText: "02", lastText: "Soft Boiled", themeColor: settingsStore.themeColor)
            }
            .modifier(slideIn(delay: 0.2, duration: 0.5, opacity: show ? 1 : 0, offsetY: show ? 0 : -50))
            
            //
            Button(action: {
                TextToSpeak.shared.speakMediumChosen()
                self.choose(eggBoil: .medium)
            }) {
                TitleView(firstText: "03", lastText: "Medium Boiled", themeColor: settingsStore.themeColor)
            }
            .modifier(slideIn(delay: 0.3, duration: 0.5, opacity: show ? 1 : 0, offsetY: show ? 0 : -50))
            
            //
            Button(action: {
                TextToSpeak.shared.speakHardChosen()
                self.choose(eggBoil: .hard)
                
            }) {
                TitleView(firstText: "04", lastText: "Hard Boiled", themeColor: settingsStore.themeColor)
            }
            .modifier(slideIn(delay: 0.4, duration: 0.5, opacity: show ? 1 : 0, offsetY: show ? 0 : -50))
            
        }.onAppear() {
            
            TextToSpeak.shared.speakHowDoYouWantYourEggsCooked()
            self.show = true
        }
    }
    
    // Functions
    
    func choose(eggBoil: EggBoil){
        self.viewState.eggBoil = eggBoil
        self.viewState.currentView = .running
    }
}


struct ChooseView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundView()
            DotsView(themeColor: Color.red)
            ChooseView()
        }.edgesIgnoringSafeArea(.all)
    }
}

