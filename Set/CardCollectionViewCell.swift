//
//  CardCollectionViewCell.swift
//  Set
//
//  Created by Raphael Blistein on 14.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    var cardView: CardView?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clipsToBounds = false
        contentView.subviews.forEach{ $0.removeFromSuperview() }
        cardView = nil
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            UIView.animate(withDuration: 0.1) { [unowned self] in
                self.cardView?.setState(selected: self.isSelected)
            }
        }
    }
    
    func addCardView(forCard card: PlayingCard, isSelected: Bool) {
        let cardFrame = CGRect(x: 0, y: 0, width: contentView.frame.height/1.5,
                               height: contentView.frame.height)
        cardView = CardView(frame: cardFrame, card: card, isSelected: isSelected)
        contentView.addSubview(cardView!)
        cardView!.center = contentView.center
    }
}
