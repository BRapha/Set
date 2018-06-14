//
//  GamePlayViewModel.swift
//  Set
//
//  Created by Raphael Blistein on 13.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class GamePlayViewModel {
    
    //MARK: - Public Properties
    
    var visibleCards = [PlayingCard]()
    var selectedSet = Set<PlayingCard>()
    
    //MARK: - Private Properties
    
    private var deck = fullDeck
    
    //MARK: - Init
    
    init() {
        // Deal initial hand
        for _ in 0 ..< 12 {
            visibleCards.append(deck.remove(at: deck.getRandomIndex()!))
        }
    }
    
    //MARK: - Public Methods
    
    func didSelectCard(at indexPath: IndexPath) {

    }
    
    func didDeselectCard(at indexPath: IndexPath) {
        
    }
    
    func configureCell(_ cell: UICollectionViewCell, forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        cell.contentView.subviews.forEach{ $0.removeFromSuperview() }
        cell.clipsToBounds = false
        
        guard let card = visibleCards[safe: indexPath.row] else { return cell }
        
        let cardFrame = CGRect(x: 0, y: 0, width: cell.contentView.frame.height/1.5,
                               height: cell.contentView.frame.height)
        let cardView = CardView(frame: cardFrame, card: card)
        cell.contentView.addSubview(cardView)
        cardView.center = cell.contentView.center
        
        return cell
    }
}
