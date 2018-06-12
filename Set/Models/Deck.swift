//
//  Deck.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

enum Color {
    case orange
    case green
    case purple
    
    static let allValues = [orange, green, purple]
}

extension Color: RawRepresentable {
    typealias RawValue = UIColor
    
    init?(rawValue: RawValue) {
        switch rawValue {
        case UIColor.systemOrange:
            self = .orange
        case UIColor.systemPurple:
            self = .purple
        case UIColor.systemGreen:
            self = .green
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .orange:
            return UIColor.systemOrange
        case .purple:
            return UIColor.systemPurple
        case .green:
            return UIColor.systemGreen
        }
    }
}

enum Shape: String {
    case oval, rectangle, tilde
    
    static let allValues = [oval, rectangle, tilde]
}

enum Filling: String {
    case empty, speckled, full
    
    static let allValues = [empty, speckled, full]
}

enum Value: Int {
    case one = 1
    case two = 2
    case three = 3
    
    static let allValues = [one, two, three]
}

let fullDeck: Set<PlayingCard> = {
    var set = Set<PlayingCard>()
    
    for color in Color.allValues {
        for shape in Shape.allValues {
            for value in Value.allValues {
                for filling in Filling.allValues {
                    let card = PlayingCard(color: color, shape: shape, value: value,
                                           filling: filling)
                    set.insert(card)
                }
            }
        }
    }
    
    return set
}()
