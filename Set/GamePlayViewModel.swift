//
//  GamePlayViewModel.swift
//  Set
//
//  Created by Raphael Blistein on 13.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

protocol GamePlayViewModelDelegate: class {
    func reloadView()
}

class GamePlayViewModel {
    
    //MARK: - Public Properties
    
    var visibleCards = [PlayingCard?]()
    
    //MARK: - Private Properties
    
    private weak var delegate: GamePlayViewModelDelegate?
    
    private var deck = fullDeck
    private var selectedIndexes = Set<IndexPath>()
    
    //MARK: - Init
    
    init(delegate: GamePlayViewModelDelegate) {
        self.delegate = delegate
        // Deal initial hand
        for _ in 0 ..< 12 {
            visibleCards.append(deck.removeRandomElement())
        }
    }
    
    //MARK: - Public Methods
    
    func configureCell(_ cell: CardCollectionViewCell,
                       forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let _card = visibleCards[safe: indexPath.row], let card = _card else { return cell }
        let isSelected = selectedIndexes.contains(indexPath)
        cell.addCardView(forCard: card, isSelected: isSelected )
        cell.isSelected = isSelected
        
        return cell
    }
    
    /// Don't select empty cells or any if selected count > 3
    func shouldSelectCell(at indexPath: IndexPath) -> Bool {
        return (selectedIndexes.count < 3) && (visibleCards[indexPath.row] != nil)
    }
    
    func didSelectCard(at indexPath: IndexPath) {
        selectedIndexes.insert(indexPath)
        
        if selectedIndexes.count == 3 {
            testCurrentSelection()
        }
    }
    
    func didDeselectCard(at indexPath: IndexPath) {
        selectedIndexes.remove(indexPath)
    }
    
    func dealCard() {
        if let card = deck.removeRandomElement() {
            visibleCards.append(card)
            delegate?.reloadView()
        }
    }
    
    //MARK: - Private Methods
    
    private func testCurrentSelection() {
        var selectedSet = Set<PlayingCard>()
        for indexPath in selectedIndexes {
            if let card = visibleCards[indexPath.row] {
                selectedSet.insert(card)
            }
        }
        
        if Validator.checkSet(selectedSet) {
            replaceSelectedCards()
        }
        selectedIndexes.removeAll()
        delegate?.reloadView()
    }
    
    private func replaceSelectedCards() {
        for indexPath in selectedIndexes {
            visibleCards[indexPath.row] = deck.removeRandomElement()
        }
    }
}
