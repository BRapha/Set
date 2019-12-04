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
    var players = [Player]()
    
    //MARK: - Private Properties
    
    private weak var delegate: GamePlayViewModelDelegate?
    
    private var deck = fullDeck
    private var selectedIndexes = Set<IndexPath>()
    private var validSetIndexes = Set<IndexPath>()
    private var currentPlayer: Int? = nil
    
    //MARK: - Init
    
    init(delegate: GamePlayViewModelDelegate) {
        self.delegate = delegate
        // Deal initial hand
        for _ in 0 ..< 12 {
            visibleCards.append(deck.removeRandomElement())
        }
        
        players = [Player(name: "Player 1", points: 0),
                   Player(name: "Player 2", points: 0),
                   Player(name: "Player 3", points: 0),
                   Player(name: "Player 4", points: 0)]
    }
    
    //MARK: - Public Methods
    
    func configureCell(_ cell: CardCollectionViewCell,
                       forItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let _card = visibleCards[safe: indexPath.row], let card = _card else { return cell }
        let isSelected = selectedIndexes.contains(indexPath)
        cell.addCardView(forCard: card, isSelected: isSelected )
        cell.isSelected = isSelected
        
//        let isPartOfValidSet = isHelping && validSetIndexes.contains(indexPath)
//        cell.contentView.layer.borderWidth = isPartOfValidSet ? 2 : 0
//        cell.contentView.layer.borderColor = UIColor.red.cgColor
        
        return cell
    }
    
    /// Don't select empty cells or any if selected count > 3
    func shouldSelectCell(at indexPath: IndexPath) -> Bool {
        return (currentPlayer != nil) && (selectedIndexes.count < 3) && (visibleCards[indexPath.row] != nil)
    }
    
    func didSelectCard(at indexPath: IndexPath, completion: @escaping (Bool, Int?) -> Void) {
        selectedIndexes.insert(indexPath)
        
        if selectedIndexes.count == 3 {
            testCurrentSelection { valid in
                completion(valid, valid ? nil : self.currentPlayer)
            }
        }
    }
    
    func didDeselectCard(at indexPath: IndexPath) {
        selectedIndexes.remove(indexPath)
    }
    
    func playerStartedTurn(player: Int) {
        currentPlayer = player
    }
    
    func dealCard() {
        if let card = deck.removeRandomElement() {
            visibleCards.append(card)
            delegate?.reloadView()
        }
    }
    
    func checkIfContainsValidSet(completion: @escaping (Bool) -> Void) {
        screenVisibleCards() { containsSet in
            if containsSet {
                self.changeScoreOfCurrentPlayer(by: -1)
            } else {
                self.changeScoreOfCurrentPlayer(by: 2)
                self.dealCard()
            }
            completion(containsSet)
        }
    }
    
    //MARK: - Private Methods
    
    private func changeScoreOfCurrentPlayer(by amount: Int) {
        if let currentPlayer = currentPlayer {
            players[currentPlayer].points += amount
            self.currentPlayer = nil
        }
    }
    
    private func testCurrentSelection(completion: @escaping ((Bool) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            let selectedCards = self.selectedIndexes.map{self.visibleCards[$0.row]}.compactMap{$0}
            let valid = Validator.isSetValid(Set(selectedCards))
            DispatchQueue.main.async {
                completion(valid)
                if valid {
                    self.changeScoreOfCurrentPlayer(by: 1)
                    self.replaceSelectedCards()
                }
                self.selectedIndexes.removeAll()
                self.delegate?.reloadView()
            }
        }
    }
    
    /// Replaces visible selected cards from valid set while trying to reduce visible cards to 12
    private func replaceSelectedCards() {
        let indexesToReplace = selectedIndexes.map({$0.row}).sorted(by: {$0 > $1})
        
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
    
    private func screenVisibleCards(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [unowned self] in
            SetFinder.findValidIndexes(in: self.visibleCards) { sets in
                self.validSetIndexes = Set(sets.map{IndexPath(row: $0, section: 0)})
                DispatchQueue.main.async {
                    completion(sets.count > 0)
                }
            }
        }
    }
}
