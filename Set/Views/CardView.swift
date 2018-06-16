//
//  CardView.swift
//  Set
//
//  Created by Raphael Blistein on 11.06.18.
//  Copyright © 2018 Raphael Blistein. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    // MARK: - Public Properties
    
    var isSelected = false {
        didSet {
            let whiteFactor: CGFloat = isSelected ? 1 : 0.97
            backgroundColor = UIColor(white: whiteFactor, alpha: 1)
            
            layer.shadowRadius = isSelected ? 5 : 1
            let offset: CGFloat = isSelected ? 5 : 1
            layer.shadowOffset = CGSize(width: offset, height: offset)
            
            let scaleFactor: CGFloat = isSelected ? 1.1 : 1
            transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
        }
    }
    
    // MARK: - Private Properties
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 2/3)
            ])
        
        return stackView
    }()
    
    // MARK: - Init
    
    init(card: PlayingCard, isSelected: Bool = false) {
        super.init(frame: CGRect.zero)
        commonInit(card: card, isSelected: isSelected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.spacing = self.frame.height / 10
        addShadow()
    }
    
    // MARK: - Private Methods
    
    private func commonInit(card: PlayingCard, isSelected: Bool) {
        formatView()
        addShapes(card: card)
        self.isSelected = isSelected
    }
    
    private func formatView() {
        layer.cornerRadius = 10
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
    }
    
    private func addShapes(card: PlayingCard) {
        let image = UIImage(named: "\(card.shape)_\(card.filling)")?
            .withRenderingMode(.alwaysTemplate)
        
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
