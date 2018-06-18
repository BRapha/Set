//
//  Validator.swift
//  Set
//
//  Created by Raphael Blistein on 15.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

struct Validator {
    
    /// Checks the validity of a set of cards according to the game's rules.
    //  Note: Optimized for performance: Falls through to next when 'true' (power of 'OR' statement)
    //      and returns false as soon as one feature is invalid
    static func isSetValid(_ set: Set<PlayingCard>) -> Bool {
        guard set.count == 3 else { return false }
        
        let colors = set.map{ $0.color }
        let colorValidity = testIfAllEqual(colors) || testIfAllDifferent(colors)
        guard colorValidity else { return false }
        
        let values = set.map{ $0.value }
        let valueValidity = testIfAllEqual(values) || testIfAllDifferent(values)
        guard valueValidity else { return false }
        
        let shapes = set.map{ $0.shape }
        let shapeValidity = testIfAllEqual(shapes) || testIfAllDifferent(shapes)
        guard shapeValidity else { return false }
        
        let fillings = set.map{ $0.filling }
        return testIfAllEqual(fillings) || testIfAllDifferent(fillings)
    }
    
    private static func testIfAllEqual<T: Hashable>(_ features: Array<T>) -> Bool {
        var allEqual = true
        guard let first = features.first else { return allEqual }
        
        for element in features.dropFirst().enumerated() {
            allEqual = allEqual && (first == element.element)
        }
        return allEqual
    }
    
    private static func testIfAllDifferent<T: Hashable>(_ features: Array<T>) -> Bool {
        var allDifferent = true
        for elemet in features.enumerated() {
            for i in elemet.offset+1 ..< features.endIndex {
                allDifferent = allDifferent && (elemet.element != features[i])
            }
        }
        return allDifferent
    }
}
