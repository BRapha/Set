//
//  ViewController.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Private Properties
    
    private var deck = fullDeck
    private var visibleCards = [PlayingCard]()
    private var spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
    
        dealInitial()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
    
    private func dealInitial() {
        for _ in 0 ..< 12 {
            visibleCards.append(deck.remove(at: deck.getRandomIndex()!))
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return visibleCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier",
                                                      for: indexPath)
        cell.contentView.subviews.forEach{ $0.removeFromSuperview() }
        
        guard let card = visibleCards[safe: indexPath.row] else { return cell }
        cell.backgroundColor = .cyan
        let cardFrame = CGRect(x: 0, y: 0, width: cell.contentView.frame.height/1.5,
                               height: cell.contentView.frame.height)
        let cardView = CardView(frame: cardFrame, card: card)
        cell.contentView.addSubview(cardView)
        cardView.center = cell.contentView.center
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Do stuff
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        //TODO Undo stuff
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    /// Always display 3 items per row
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxItemWidth: CGFloat = (collectionView.frame.width - 4 * spacing) / 3
        
        let numberOfCards = visibleCards.count
        let numberOfRows = (numberOfCards%3 == 0) ? numberOfCards/3 : numberOfCards/3 + 1
        let maxItemHeight: CGFloat = (collectionView.frame.height
            - CGFloat(numberOfRows + 1) * spacing) / CGFloat(numberOfRows)
        let itemHeight = min(maxItemWidth*1.5, maxItemHeight)
        
        return CGSize(width: maxItemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}
