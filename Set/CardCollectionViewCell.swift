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
        contentView.subviews.forEach{ $0.removeFromSuperview() }
        cardView = nil
    }
    
    override var isSelected: Bool {
        didSet {
            guard isSelected != oldValue else { return }
            UIView.animate(withDuration: 0.15) { [unowned self] in
                self.cardView?.isSelected = self.isSelected
            }
        }
    }
    
    func addCardView(forCard card: PlayingCard, isSelected: Bool) {
        clipsToBounds = false
        cardView = CardView(card: card, isSelected: isSelected)
        contentView.addSubview(cardView!)
        cardView!.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardView!.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            cardView!.widthAnchor.constraint(equalTo: cardView!.heightAnchor, multiplier: 1/1.5),
            cardView!.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            cardView!.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
}
