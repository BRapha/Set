//
//  SetExtension.swift
//  Set
//
//  Created by Raphael Blistein on 13.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import Foundation

// TODO: Reduce complexity to O(1) by conforming to Random Access Collection: https://developer.apple.com/documentation/swift/randomaccesscollection
extension Set {
    mutating func removeRandomElement() -> Element? {
        guard count > 0 else { return nil }
        let rand = Int(arc4random_uniform(UInt32(count)))
        let randomIndex = self.index(self.startIndex, offsetBy: rand)
        return self.remove(at: randomIndex)
    }
}
