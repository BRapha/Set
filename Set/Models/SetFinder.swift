//
//  SetFinder.swift
//  Set
//
//  Created by Raphael Blistein on 16.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

struct SetFinder {
    
    /// Finds valid sets of 3 cards each within all possible combinations within collection
    static func findValidSets(in collection: [PlayingCard?]) -> [Set<PlayingCard>] {
        var validSets = [Set<PlayingCard>]()
        guard collection.count > 2 else { return validSets }
        for item in collection.enumerated() where item.offset < collection.count-2 {
            for i in item.offset+1 ..< collection.endIndex-1 {
                for j in i+1 ..< collection.endIndex {
                    let set = Set([item.element, collection[i], collection[j]].compactMap{$0})
                    if Validator.isSetValid(set) {
                        validSets.append(set)
                    }
                }
            }
        }
        
        return validSets
    }
    
    
    /// Finds valid sets of 3 cards each within all possible combinations within collection
    static func findValidIndexes(in collection: [PlayingCard?]) -> Set<Int> {
        var validSets = Set<Int>()
        guard collection.count > 2 else { return validSets }
        for item in collection.enumerated() where item.offset < collection.count-2 {
            for i in item.offset+1 ..< collection.endIndex-1 {
                for j in i+1 ..< collection.endIndex {
                    if Validator.isSetValid(Set([
                        item.element, collection[i], collection[j]
                        ].compactMap{$0})) {
                        validSets.insert(item.offset)
                        validSets.insert(i)
                        validSets.insert(j)
                    }
                }
            }
        }
        
        return validSets
    }
}
