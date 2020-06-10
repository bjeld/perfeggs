//
//  PlaySound.swift
//  perfeggs
//
//  Created by Martin Bjeld on 23/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Foundation
import AVFoundation

// MARK: - AudioPlayer

var audioPlayer: AVAudioPlayer?



func playSound(sound:String, type:String, loop:Bool, delay:Double) -> AVAudioPlayer? {
    
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            
            if loop {
                audioPlayer?.numberOfLoops = -1
            }
            
            audioPlayer?.prepareToPlay()
       

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                // your code here
               audioPlayer?.play()
            }
            
            
            
            return audioPlayer
        } catch {
            print("could not play audio")
        }
    }
    return nil
}
