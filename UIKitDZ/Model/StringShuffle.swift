//
//  StringShuffle.swift
//  UIKitDZ
//
//  Created by muxammed on 22.09.2022.
//

import Foundation
/// Models file
struct StringShuffle {
    let toBeShuffled: String
    
    func shuffleString(toBeShuffled: String) -> (String, Bool) {
        print("gele \(toBeShuffled)")
        return toBeShuffled.lowercased() == "leohl" ? ("hello", true) : ("Please enter the \"leohl\"", false)
    }
}
