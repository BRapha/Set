//
//  PlayingCard.swift
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
        case UIColor.customOrange:
            self = .orange
        case UIColor.systemPurple:
            self = .purple
        case UIColor.customGreen:
            self = .green
        default:
            return nil
        }
    }
    
    var rawValue: RawValue {
        switch self {
        case .orange:
            return UIColor.customOrange
        case .purple:
            return UIColor.systemPurple
        case .green:
            return UIColor.customGreen
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

struct PlayingCard: Hashable {
    let color: Color
    let shape: Shape
    let value: Value
    let filling: Filling
    
    static func ==(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.value == rhs.value
            && lhs.filling == rhs.filling
    }
}
