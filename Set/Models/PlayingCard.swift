//
//  PlayingCard.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

struct PlayingCard: Hashable {
    let color: Color
    let shape: Shape
    let number: Number
    let filling: Filling
    
    static func ==(lhs: PlayingCard, rhs: PlayingCard) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.number == rhs.number
            && lhs.filling == rhs.filling
    }
}
