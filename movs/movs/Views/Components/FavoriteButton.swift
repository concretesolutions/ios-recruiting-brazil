//
//  FavoriteButton.swift
//  movs
//
//  Created by Emerson Victor on 10/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    // MARK: - Attributes
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.isSelected {
                    self.setBackgroundImage(UIImage(systemName: "heart.fill"),
                                            for: .normal)
                    self.tintColor = .systemRed
                } else {
                    self.setBackgroundImage(UIImage(systemName: "heart"),
                                            for: .normal)
                    self.tintColor = self.baseTintColor
                }
            }
        }
    }
    
    let baseTintColor: UIColor
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, baseTintColor: UIColor) {
        self.baseTintColor = baseTintColor
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
