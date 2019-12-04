//
//  FavoriteButton.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    // MARK: - Attributes
    
    private var imageName: String = "heart"
    
    // MARK: - Initializers and Deinitializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .red
        self.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 3.0, bottom: 5.0, right: 5.0)
        self.addTarget(self, action: #selector(self.handleTouchUpInside), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - Gesture Recognizers
    
    @objc func handleTouchUpInside() {
        self.imageName = self.imageName == "heart" ? "heart.fill" : "heart"
        
        UIView.transition(with: self, duration: 0.15, options: .transitionCrossDissolve, animations: {
            self.setImage(UIImage(systemName: self.imageName), for: .normal)
        })
    }
}
