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
    private var validSetIndexes = Set<IndexPath>()
    private var isHelping = false {
        didSet {
            if isHelping { screenVisibleCards() }
        }
    }
    
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
        
        let isPartOfValidSet = isHelping && validSetIndexes.contains(indexPath)
        cell.contentView.layer.borderWidth = isPartOfValidSet ? 2 : 0
        cell.contentView.layer.borderColor = UIColor.red.cgColor
        
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
            isHelping = false
            delegate?.reloadView()
        }
    }
    
    func help() {
        isHelping = true
        delegate?.reloadView()
    }
    
    //MARK: - Private Methods
    
    private func testCurrentSelection() {
        var selectedSet = Set<PlayingCard>()
        for indexPath in selectedIndexes {
            if let card = visibleCards[indexPath.row] {
                selectedSet.insert(card)
            }
        }
        
        if Validator.isSetValid(selectedSet) {
            replaceSelectedCards()
            isHelping = false
        }
        selectedIndexes.removeAll()
        delegate?.reloadView()
    }
    
    /// Replaces visible selected cards from valid set while trying to reduce visible cards to 12
    private func replaceSelectedCards() {
        let indexesToReplace = selectedIndexes.map({ $0.row }).sorted(by: { $0>$1 })
        
        for i in indexesToReplace {
            if i >= 12 {
                visibleCards.remove(at: i)
            } else {
                if visibleCards.count > 12 {
                    visibleCards[i] = visibleCards.removeLast()
                } else {
                    visibleCards[i] = deck.removeRandomElement()
                }
            }
        }
    }
    
    private func screenVisibleCards() {
        let sets = SetFinder.findValidIndexes(in: visibleCards)
        
        validSetIndexes = Set(sets.map{IndexPath(row: $0, section: 0)})
        if validSetIndexes.count > 0 {
            delegate?.reloadView()
        }
    }
}
