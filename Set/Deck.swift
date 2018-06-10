//
//  Deck.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

enum Colors {
    case red, green, purple
    
    static let allValues = [red, green, purple]
}

enum Shapes {
    case ellipsis, rectangle, tilde
    
    static let allValues = [ellipsis, rectangle, tilde]
}

enum Numbers {
    case one, two, three
    
    static let allValues = [one, two, three]
}

enum Fillings {
    case empty, speckled, full
    
    static let allValues = [empty, speckled, full]
}



let deck: Set<PlayingCard> = {
    let set = Set<PlayingCard>()
    
    for color in Colors.allValues {
        
    }
    
    return set
}()
