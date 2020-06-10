//
//  Audio.swift
//  perfeggs
//
//  Created by Martin Bjeld on 22/04/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Foundation
import AVFoundation

// Functions
  

class Audio {
    
    // MARK: - Properties
   static let shared = Audio()
       
   
    var musicSoundLoop: AVAudioPlayer?
    var timeNoticeSound: AVAudioPlayer?
    var uiTransitionSound: AVAudioPlayer?
       
    func playMusicSoundLoop() -> Void {
        
         let path = Bundle.main.path(forResource: "Red_Sun_Music_Loop.wav", ofType: nil)!
         let url = URL(fileURLWithPath: path)
         
         do {
            musicSoundLoop = try AVAudioPlayer(contentsOf: url)
            musicSoundLoop?.numberOfLoops = -1
            musicSoundLoop?.play()
         }
         catch {
             
         }
     }
    
    func toggleMusicVolume() -> Void {
        print("toggleMusicVolume")
        if let player = musicSoundLoop  {
            if player.isPlaying {
                player.setVolume(0, fadeDuration: 2)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    player.pause()
                }
            }
            else {
                player.play()
                player.setVolume(1, fadeDuration: 2)
            }
        }
        
        
        
    }
    
    func playUITransition() -> Void {
        
        let path = Bundle.main.path(forResource: "UI_Confirm.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            uiTransitionSound = try AVAudioPlayer(contentsOf: url)
            uiTransitionSound?.play()
        }
        catch {
            
        }
    }
    
    func playTimeNotice1() -> Void {
        let path = Bundle.main.path(forResource: "Kill_Enemy_4.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
                
        do {
            timeNoticeSound = try AVAudioPlayer(contentsOf: url)
            timeNoticeSound?.play()
        }
        catch {
            
        }
    }
    
    func playTimeNotice2() -> Void {
        let path = Bundle.main.path(forResource: "Kill_Enemy_5.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
                
        do {
            timeNoticeSound = try AVAudioPlayer(contentsOf: url)
            timeNoticeSound?.play()
        }
        catch {
            
        }
    }
    
    func playTimeNotice3() -> Void {
        let path = Bundle.main.path(forResource: "Kill_Enemy_6.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
                
        do {
            timeNoticeSound = try AVAudioPlayer(contentsOf: url)
            timeNoticeSound?.play()
        }
        catch {
            
        }
    }
    
    func playTimeNotice4() -> Void {
        let path = Bundle.main.path(forResource: "Kill_Enemy_7.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
                
        do {
            timeNoticeSound = try AVAudioPlayer(contentsOf: url)
            timeNoticeSound?.play()
        }
        catch {
            
        }
    }
}
