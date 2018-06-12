//
//  ViewController.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = fullDeck
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let card = PlayingCard(color: .orange, shape: .tilde, number: .three, filling: .speckled)
        let cardView = CardView(frame: CGRect(x: 50, y: 50, width: 100, height: 150), card: card)
        
        view.addSubview(cardView)
    }


}

