//
//  CardView.swift
//  Set
//
//  Created by Raphael Blistein on 11.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Init
    
    init(frame: CGRect, card: PlayingCard) {
        super.init(frame: frame)
        commonInit(card: card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(card: PlayingCard) {
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .white
        
        addShapes(card: card)
    }
    
    private func addShapes(card: PlayingCard) {
        let image = UIImage(named: "\(card.shape)_\(card.filling)")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = card.color.rawValue
        
        for _ in 1 ..< card.number.rawValue {
            let additionalImageView = UIImageView(image: image)
            additionalImageView.translatesAutoresizingMaskIntoConstraints = false
            additionalImageView.heightAnchor.constraint(equalTo: additionalImageView.widthAnchor,
                                                        multiplier: 1/3).isActive = true
            additionalImageView.tintColor = card.color.rawValue

            stackView.addArrangedSubview(additionalImageView)
        }
    }
    
}
