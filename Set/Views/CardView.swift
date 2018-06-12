//
//  CardView.swift
//  Set
//
//  Created by Raphael Blistein on 11.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3)
            ])
        
        stackView.axis = .vertical
        stackView.spacing = self.frame.height / 10
        return stackView
    }()
    
    // MARK: - Init
    
    init(frame: CGRect, card: PlayingCard) {
        super.init(frame: frame)
        commonInit(card: card)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func commonInit(card: PlayingCard) {
        self.backgroundColor = .white
        addShapes(card: card)
    }
    
    private func addShapes(card: PlayingCard) {
        let image = UIImage(named: "\(card.shape)_\(card.filling)")?.withRenderingMode(.alwaysTemplate)
        
        for _ in 0 ..< card.value.rawValue {
            let imageView = UIImageView(image: image)
            imageView.tintColor = card.color.rawValue
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                             multiplier: 3).isActive = true
            stackView.addArrangedSubview(imageView)
        }
    }
}
