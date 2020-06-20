//
//  Countdown.swift
//  perfeggs
//
//  Created by Martin Bjeld on 04/05/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Foundation
import UserNotifications

class Countdown: ObservableObject {
    
    var timer:Timer?
    var future: Date?
    var eggBoilTimeInSeconds:Int?
    let calendar = Calendar(identifier: .gregorian)
    
    @Published var running = false // defaults to stopped -> user has to start timer when ready
    @Published var finished = false
    @Published var remainingTimeInSeconds:Int = 0
    @Published var progess: Double = 0.0 // Tracks the overall progress of the ticking timer. Value between 0 - 1
    
    init() {
        self.askForUserPermissionToSendLocationNotifications()
    }
    
    // MARK: - Public API
    
    func setup(eggBoilTimeInSeconds: Int, resumeFromRecreated:Bool = false) -> Void {
        self.eggBoilTimeInSeconds = eggBoilTimeInSeconds
        self.finished = false
        self.running = resumeFromRecreated
        print(eggBoilTimeInSeconds)
    }
    
    func start() -> Void {
        print("=== START ===")
        guard let time = self.eggBoilTimeInSeconds else { return }
        
        self.future = Date().addingTimeInterval(TimeInterval(time))
        self.finished = false
        self.running = true
        self.tick()
        self.startTimer()
    }
    
    func stop() -> Void {
        print("=== STOP ===")
        self.stopTimer()
        self.future = nil
        self.progess = 0.0
        self.remainingTimeInSeconds = 0
        self.finished = false
        self.running = false
    }
    
    func finish() -> Void {
        self.stopTimer()
        self.future = nil
        self.progess = 0.0
        self.remainingTimeInSeconds = 0
        self.finished = true
        self.running = false
        
        TextToSpeak.shared.speakEggIsDone()
    }
    
    // MARK: - Timer / Counter
    
    private func startTimer() -> Void {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.tick()
        }
    }
    
    private func stopTimer() -> Void {
        self.timer?.invalidate()
    }
    
    private func tick() -> Void {
        guard let future = self.future else { return }
        guard let timeInSeconds = self.eggBoilTimeInSeconds else { return }
        guard let remainingTime = calendar.dateComponents([.second], from: Date(), to: future).second else { return }
        
        // print(self.progess)
        
        if self.progess >= 1 {
            self.finish()
        }
        else {
            self.progess = 1 - (Double(remainingTime) / Double(timeInSeconds))
            self.remainingTimeInSeconds = remainingTime
        }
    }
    
    // MARK: - Persistance
    
    func persistCountdown() -> Void {
        if !self.running { return }
        if self.remainingTimeInSeconds <= 0 { return }
        
        self.scheduleLocalNotification(Double(self.remainingTimeInSeconds))
        
        if let future = self.future, let eggBoilTimeInSeconds = self.eggBoilTimeInSeconds {
            let futureReference = future.timeIntervalSince1970
            // save that future finish date
            UserDefaults.standard.set(futureReference, forKey: "futureReference")
            // save total egg boiling time
            UserDefaults.standard.set(eggBoilTimeInSeconds, forKey: "eggBoilTimeInSeconds")
        }
    }
    
    func recreatePersistedCounter() -> Void {
        
        self.cancelAnySheduledLocalNotifications()
        
        let futureReference = UserDefaults.standard.integer(forKey: "futureReference")
        let eggBoilTimeInSeconds = UserDefaults.standard.integer(forKey: "eggBoilTimeInSeconds")
        
        if futureReference > 0 {
            let nowReference = Int(Date().timeIntervalSince1970.rounded())
            
            let diff:Double = Double(futureReference - nowReference)
            if diff > 0 {
                
                self.setup(eggBoilTimeInSeconds: eggBoilTimeInSeconds, resumeFromRecreated: true)
                self.remainingTimeInSeconds = Int(diff)
                self.progess = 1 - (Double(diff) / Double(eggBoilTimeInSeconds))
                
            }
            
            UserDefaults.standard.removeObject(forKey: "futureReference")
        }
    }
    
    // MARK: - Local Notifications
    
    private func scheduleLocalNotification(_ sec: Double) -> Void {
        let content = UNMutableNotificationContent()
        content.title = "Timer is done!"
        content.subtitle = "Take your eggs out of the boiling water"
        content.sound =  UNNotificationSound.init(named:UNNotificationSoundName(rawValue: "alert01.m4a"))
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(sec), repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    private func cancelAnySheduledLocalNotifications() -> Void {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func askForUserPermissionToSendLocationNotifications() -> Void {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
