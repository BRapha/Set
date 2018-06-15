//
//  Validator.swift
//  Set
//
//  Created by Raphael Blistein on 15.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

struct Validator {
    
    static func checkSet(_ set: Set<PlayingCard>) -> Bool {
        guard set.count == 3 else { return false }
        return checkColor(set) && checkShape(set) && checkValue(set) && checkFilling(set)
    }
    
    private static func checkColor(_ set: Set<PlayingCard>) -> Bool {
        let feat = set.map { $0.color }
        let allDifferent = feat[0] != feat[1] && feat[1] != feat[2] && feat[2] != feat[0]
        let allSame = feat[0] == feat[1] && feat[1] == feat[2]
        return allDifferent || allSame
    }
    
    private static func checkShape(_ set: Set<PlayingCard>) -> Bool {
        let feat = set.map { $0.shape }
        let allDifferent = feat[0] != feat[1] && feat[1] != feat[2] && feat[2] != feat[0]
        let allSame = feat[0] == feat[1] && feat[1] == feat[2]
        return allDifferent || allSame
    }
    
    private static func checkValue(_ set: Set<PlayingCard>) -> Bool {
        let feat = set.map { $0.value }
        let allDifferent = feat[0] != feat[1] && feat[1] != feat[2] && feat[2] != feat[0]
        let allSame = feat[0] == feat[1] && feat[1] == feat[2]
        return allDifferent || allSame
    }
    
    private static func checkFilling(_ set: Set<PlayingCard>) -> Bool {
        let feat = set.map { $0.filling }
        let allDifferent = feat[0] != feat[1] && feat[1] != feat[2] && feat[2] != feat[0]
        let allSame = feat[0] == feat[1] && feat[1] == feat[2]
        return allDifferent || allSame
    }
}
