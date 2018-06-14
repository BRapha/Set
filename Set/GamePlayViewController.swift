//
//  GamePlayViewController.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Private Properties
    
    private lazy var viewModel = GamePlayViewModel(delegate: self)
    private var spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
}

extension GamePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.visibleCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier",
                                                      for: indexPath) as! CardCollectionViewCell
        let configuredCell = viewModel.configureCell(cell, forItemAt: indexPath)
        if configuredCell.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        }
        return configuredCell
    }

    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return viewModel.shouldSelectCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCard(at: indexPath)        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.didDeselectCard(at: indexPath)
    }
}

extension GamePlayViewController: UICollectionViewDelegateFlowLayout {
    
    /// Always display 3 items per row
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxItemWidth: CGFloat = (collectionView.frame.width - 4 * spacing) / 3
        
        let numberOfCards = viewModel.visibleCards.count
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

extension GamePlayViewController: GamePlayViewModelDelegate {
    func reloadView() {
        collectionView.reloadData()
    }
}
