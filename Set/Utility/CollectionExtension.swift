//
//  CollectionExtension.swift
//  Set
//
//  Created by Raphael Blistein on 13.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

extension Collection {
    
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
