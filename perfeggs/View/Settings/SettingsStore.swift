//
//  SettingsStore.swift
//  perfeggs
//
//  Created by Martin Bjeld on 29/05/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Combine
import SwiftUI

class SettingsStore: ObservableObject {
    // https://swiftwithmajid.com/2019/06/19/building-forms-with-swiftui/
    private let defaults: UserDefaults
    
    let objectWillChange = PassthroughSubject<Void, Never>()
    
    private enum Keys {
        static let eggBoilMode = "egg_boil_mode"
        static let eggStorageMode = "egg_storage_mode"
    }
    
    enum EggBoilMode: String, CaseIterable {
        case choose = "Decide after scanning egg"
        case skipToVerySoftBoiled = "Skip to Very soft boiled timer"
        case skipToSoftBoiled = "Skip to soft boiled timer"
        case skipToMediumBoiled = "Skip to medium boiled timer"
        case skipToHardBoiled = "Skip to hard boiled timer"
    }
    
    enum EggStorageMode: String, CaseIterable {
        case fridge = "Fridge"
        case room = "Room"
    }
    
    
    var themeColor: Color {
        get {
            return Color(#colorLiteral(red: 0.9823682904, green: 0.465690136, blue: 0.3660199642, alpha: 1))
            // return Color.pink
        }
    }
    
    private func changeIcon(to iconName:String?) {
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
                       print(error.debugDescription)
                   }
    }
    
    var eggBoilMode: EggBoilMode {
        get {
            return defaults.string(forKey: Keys.eggBoilMode)
                .flatMap { EggBoilMode(rawValue: $0) } ?? .choose
        }
        
        set {
            defaults.set(newValue.rawValue, forKey: Keys.eggBoilMode)
            
            
            
            switch newValue {
            case .skipToVerySoftBoiled:
                changeIcon(to: "VerySoft")
            case .skipToSoftBoiled:
                changeIcon(to: "Soft")
            case .skipToMediumBoiled:
                changeIcon(to: "Medium")
            case .skipToHardBoiled:
                changeIcon(to: "Hard")
            
            default:
                changeIcon(to: nil)
            }
            
            
           
        }
    }
    
    var eggStorageMode: EggStorageMode {
        get {
            return defaults.string(forKey: Keys.eggStorageMode)
                .flatMap { EggStorageMode(rawValue: $0) } ?? .fridge
        }
        
        set {
            defaults.set(newValue.rawValue, forKey: Keys.eggStorageMode)
        }
    }
    
    
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
        
        defaults.register(defaults: [
            Keys.eggBoilMode: EggBoilMode.choose.rawValue,
            Keys.eggStorageMode: EggStorageMode.fridge.rawValue
        ])
        
        
    }
    
   
    
   
    
   
}
