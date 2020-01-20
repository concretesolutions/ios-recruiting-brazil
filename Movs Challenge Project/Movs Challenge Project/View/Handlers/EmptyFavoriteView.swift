//
//  EmptyFavoriteView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 20/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class EmptyFavoriteView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    
    private let heartImageView = UIImageView()
    private let mensageTextLabel = UILabel()
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            heartImageView,
            mensageTextLabel
        )
    }
    
    private func renderLayout() {
        heartImageView.size(200).centerHorizontally().Bottom - 16 == CenterY
        mensageTextLabel.left(>=16).right(>=16).centerHorizontally().Top + 16 == CenterY
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
        heartImageView.style { (s) in
            s.image = .heartImage
            s.tintColor = .mvYellow
        }
        mensageTextLabel.style { (s) in
            s.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            s.textColor = .mvText
            s.textAlignment = .center
            s.numberOfLines = 0
            s.text = "Favorite movies to show them here."
        }
    }
}
