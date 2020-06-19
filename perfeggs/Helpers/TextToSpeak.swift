//
//  TextToSpeak.swift
//  perfeggs
//
//  Created by Martin Bjeld on 21/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Foundation
import AVFoundation

class TextToSpeak {
    // MARK: - Properties
    static let shared = TextToSpeak()
    
    var lang = "en-US"
    
    let synthesizer = AVSpeechSynthesizer()
    
    func speakSmallEggSize() -> Void {
        speakWeight("Small egg")
    }
    
    func speakMediumEggSize() -> Void {
        speakWeight("Medium egg")
    }
    
    func speakLargeEggSize() -> Void {
        speakWeight("Large egg")
    }
    
    func speakExtraLargeEggSize() -> Void {
        speakWeight("Extra large egg")
    }
    
    func speakPutEggOnScreen() -> Void {
        speak("Place an egg on the screen")
    }
    
    func speakScanning() -> Void {
        speak("Scanning egg, please wait")
    }
    
    func speakTimerStarted() -> Void {
        speak("Timer started")
    }
    
    func speakPutEggsInBoilingWater() -> Void {
        speak("Put your eggs in boiling water, then start the timer")
    }
    
    func speakHowDoYouWantYourEggsCooked() -> Void {
        speak("How do you want your egg cooked?")
    }
    
    func speakExtraSoftChosen() -> Void {
        speak("Extra soft boiled chosen")
    }
    
    func speakSoftChosen() -> Void {
        speak("soft boiled chosen")
    }
    
    func speakMediumChosen() -> Void {
        speak("Medium boiled chosen")
    }
    
    func speakHardChosen() -> Void {
        speak("Hard boiled chosen")
    }
    
    func speakEggIsDone() -> Void {
        speak("Timer finished!. Put eggs in cold water shortly, to prevent further cooking")
    }
    
    private func speak(_ text:String) {
        
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: lang)
        utterance.pitchMultiplier = 1
        synthesizer.speak(utterance)
    }
    
    private func speakWeight(_ text:String) {
        speak("\(text). Remove egg from screen")
    }
    
}
