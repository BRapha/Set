//
//  FullDeck.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

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
