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
    @IBOutlet weak var checkSetButton: UIButton!
    @IBOutlet weak var playerOneButton: UIButton!
    @IBOutlet weak var playerTwoButton: UIButton!
    @IBOutlet weak var playerThreeButton: UIButton!
    @IBOutlet weak var playerFourButton: UIButton!

    //MARK: - Private Properties
    
    private lazy var viewModel = GamePlayViewModel(delegate: self)
    private var spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.groupTableViewBackground
        
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.isScrollEnabled = false
        
        updateButtonState(mode: GamePlayVCMode.newGame)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
    }
    
    //MAKR: - IBActions

    @IBAction func playerButtonPushed(_ sender: UIButton) {
        viewModel.playerStartedTurn(player: sender.tag)
        updateButtonState(mode: GamePlayVCMode.playersTurn(player: sender.tag))
    }
    
    @IBAction func checkSet(_ sender: UIButton) {
        viewModel.checkIfContainsValidSet { [unowned self] containsSet in
            self.showActionResult(success: !containsSet, points: containsSet ? -1 : 2)
            self.updateButtonState(mode: GamePlayVCMode.continueGame(disabledPlayer: nil))
        }
    }
    
    @IBAction func settings(_ sender: UIButton) {
    }
    
    //MARK: - Private Methods

    private func updateButtonState(mode: GamePlayVCMode) {
        switch mode {
        case .newGame:
            for button in [playerOneButton, playerTwoButton, playerThreeButton, playerFourButton]
                .enumerated() {
                    button.element?.tag = button.offset
                    button.element?.isHidden = button.offset >= viewModel.players.count
                    button.element?.backgroundColor = .clear
            }
        case .playersTurn(let player):
            for button in [playerOneButton, playerTwoButton, playerThreeButton, playerFourButton]
                .enumerated() {
                    button.element?.isEnabled = false
                    if button.offset == player {
                        button.element?.backgroundColor = UIColor.red.withAlphaComponent(0.25)
                    }
            }
        case .continueGame(let disabledPlayer):
            for button in [playerOneButton, playerTwoButton, playerThreeButton, playerFourButton]
                .enumerated() {
                    button.element?.backgroundColor = .clear
                    button.element?.isEnabled = !(button.element?.tag == disabledPlayer)
            }
        case .checking:
            break
        }
    }
    
    private func showActionResult(success: Bool, points: Int?) {
        let checkView = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        checkView.center = view.center
        checkView.layer.cornerRadius = 25
        checkView.layer.masksToBounds = true
        
        let blurEffectView = UIVisualEffectView(frame: checkView.bounds)
        blurEffectView.effect = UIBlurEffect(style: .prominent)
        checkView.addSubview(blurEffectView)
        
        let stackView = UIStackView(frame: checkView.bounds)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 8
        checkView.addSubview(stackView)
        
        let image: UIImage
        if success {
            if let points = points, abs(points) > 1 {
                image = #imageLiteral(resourceName: "successKid")
            } else {
                image = #imageLiteral(resourceName: "checkMark")
            }
        } else {
            image = #imageLiteral(resourceName: "cross")
        }
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imageView)
        
        if let points = points {
            let label = UILabel()
            label.font = UIFont.preferredFont(forTextStyle: .title3)
            label.text = "\(success ? "+ " : "")\(points) \(abs(points) > 1 ? "Points" : "Point")"
            label.textAlignment = .center
            stackView.addArrangedSubview(label)
            label.sizeToFit()
        }
        
        view.addSubview(checkView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            checkView.removeFromSuperview()
        }
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
        return viewModel.shouldSelectCell(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectCard(at: indexPath) { valid, playerToDeactivate in
            self.showActionResult(success: valid, points: valid ? 1 : nil)
            self.updateButtonState(mode: .continueGame(disabledPlayer: playerToDeactivate))
        }
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
