//
//  GamePlayViewController.swift
//  Set
//
//  Created by Raphael Blistein on 08.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class GampePlayViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    //MARK: - Private Properties
    
    private lazy var viewModel = GamePlayViewModel()
    private var spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
        collectionView.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
}

extension GampePlayViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.visibleCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseIdentifier",
                                                      for: indexPath)
        return viewModel.configureCell(cell, forItemAt: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return viewModel.selectedSet.count < 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCard(at: indexPath)
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .red
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.didDeselectCard(at: indexPath)
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .clear
    }
}

extension GampePlayViewController: UICollectionViewDelegateFlowLayout {
    
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
