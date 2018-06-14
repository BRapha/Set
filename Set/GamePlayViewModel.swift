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
    
    func shouldSelectCell() -> Bool {
        return selectedSet.count < 3
    }
    
    func didSelectCard(at indexPath: IndexPath) {
        
    }
    
    func didDeselectCard(at indexPath: IndexPath) {
        
    }
    
    func configureCell(_ cell: CardCollectionViewCell,
                       forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let card = visibleCards[safe: indexPath.row] else { return cell }
        
        let isSelected = indexPath.row == 5
        cell.addCardView(forCard: card, isSelected: isSelected )
        cell.isSelected = isSelected
        return cell
    }
}
