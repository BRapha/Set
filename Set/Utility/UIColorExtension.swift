//
//  UIColorExtension.swift
//  Set
//
//  Created by Raphael Blistein on 11.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(redByte red: Int, greenByte green: Int, blueByte blue: Int, alpha: CGFloat = 1) {
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255,
                  alpha: alpha)
    }
    
    // [Apple System Colors](https://developer.apple.com/ios/human-interface-guidelines/visual-design/color/)
    static let systemOrange = UIColor(redByte: 255, greenByte: 149, blueByte: 0)
    static let systemGreen = UIColor(redByte: 76, greenByte: 217, blueByte: 100)
    static let systemPurple = UIColor(redByte: 88, greenByte: 86, blueByte: 214)
    
    static let customGreen = UIColor(redByte: 0, greenByte: 160, blueByte: 30)
    static let customOrange = UIColor(redByte: 255, greenByte: 83, blueByte: 0)
}
