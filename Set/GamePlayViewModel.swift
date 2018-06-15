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
    
    var visibleCards = [PlayingCard]()
    
    //MARK: - Private Properties
    
    private weak var delegate: GamePlayViewModelDelegate?
    
    private var deck = fullDeck
    private var selectedIndexes = Set<IndexPath>()
    
    //MARK: - Init
    
    init(delegate: GamePlayViewModelDelegate) {
        // Deal initial hand
        for _ in 0 ..< 12 {
            visibleCards.append(deck.remove(at: deck.getRandomIndex()!))
        }
    }
    
    //MARK: - Public Methods
    
    func shouldSelectCell() -> Bool {
        return selectedIndexes.count < 3
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
    
    func configureCell(_ cell: CardCollectionViewCell,
                       forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let card = visibleCards[safe: indexPath.row] else { return cell }
        
        let isSelected = selectedIndexes.contains(indexPath)
        cell.addCardView(forCard: card, isSelected: isSelected )
        cell.isSelected = isSelected
        return cell
    }
    
    //MARK: - Private Methods
    
    private func testCurrentSelection() {
        var selectedSet = Set<PlayingCard>()
        for indexPath in selectedIndexes {
            selectedSet.insert(visibleCards[indexPath.row])
        }
        
        let valid = Validator.checkSet(selectedSet)
        
        print("\n --- Test set was \(valid ? "valid" : "not valid")")
    }
}
