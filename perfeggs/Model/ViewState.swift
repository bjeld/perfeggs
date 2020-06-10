//
//  ViewState.swift
//  perfeggs
//
//  Created by Martin Bjeld on 19/03/2020.
//  Copyright © 2020 Martin Bjeld. All rights reserved.
//

import Combine
import SwiftUI

enum ViewStateEnum {
    case idle
    case choose
    case running
}

enum EggSize: String {
    case small          // 45G - 52G
    case medium         // 53G - 62G
    case large          // 63G - 72G
    case extraLarge     // 73G +
}

//                      | very soft | Soft      | Medium  | Hard
//  S    =              | 3 min     | 4 min     | 5 min   | 6 min
//  M    =              | 4 min     | 5 min     | 6 min   | 7 min
//  L    =              | 5 min     | 6 min     | 7 min   | 8 min
//  XL   =              | 6 min     | 7 min     | 8 min   | 9 min
enum EggBoil: String {
    case verySoft
    case soft
    case medium
    case hard
}

let THREE_MINUTES   : Int = 3 * 60
let FOUR_MINUTES    : Int = 4 * 60
let FIVE_MINUTES    : Int = 5 * 60
let SIX_MINUTES     : Int = 6 * 60
let SEVEN_MINUTES   : Int = 7 * 60
let EIGHT_MINUTES   : Int = 8 * 60
let NINE_MINUTES    : Int = 9 * 60


class ViewState: ObservableObject {
    
    @Published var currentView : ViewStateEnum = .idle
    @Published var eggBoil: EggBoil = .medium
    @Published var eggSize : EggSize = .small
    
    public func getTimeToCook() -> Int {
        
        var result = THREE_MINUTES
        
        switch self.eggSize {
    
        case .small:
            if self.eggBoil == .verySoft    { result = THREE_MINUTES }
            if self.eggBoil == .soft        { result = FOUR_MINUTES }
            if self.eggBoil == .medium      { result = FIVE_MINUTES }
            if self.eggBoil == .hard        { result = SIX_MINUTES }
        case .medium:
            if self.eggBoil == .verySoft    { result = FOUR_MINUTES }
            if self.eggBoil == .soft        { result = FIVE_MINUTES }
            if self.eggBoil == .medium      { result = SIX_MINUTES }
            if self.eggBoil == .hard        { result = SEVEN_MINUTES }
        case .large:
            if self.eggBoil == .verySoft    { result = FIVE_MINUTES }
            if self.eggBoil == .soft        { result = SIX_MINUTES }
            if self.eggBoil == .medium      { result = SEVEN_MINUTES }
            if self.eggBoil == .hard        { result = EIGHT_MINUTES }
        case .extraLarge:
            if self.eggBoil == .verySoft    { result = SIX_MINUTES }
            if self.eggBoil == .soft        { result = SEVEN_MINUTES }
            if self.eggBoil == .medium      { result = EIGHT_MINUTES }
            if self.eggBoil == .hard        { result = NINE_MINUTES }
            
        }
        
        return result
    }
    
    public func getEggBoilLabel() -> String {
        switch eggBoil {
        case .verySoft:
            return "Extra Soft Boiled"
        case .soft :
            return "Soft Boiled"
        case .medium:
            return "Medium Boiled"
        case .hard:
            return "Hard Boiled"
        }
    }
    
    public func setWeightValue(value:CGFloat) -> Void {
        switch value {
        case 0.1...0.8:
            eggSize = .small
        case 0.8...0.85:
            eggSize = .medium
        case 0.7...0.87:
            eggSize = .large
        case 0.87...2:
            eggSize = .extraLarge
        default:
            eggSize = .medium
        }
        
        
    }
}


