//
//  FavoriteButton.swift
//  movs
//
//  Created by Emerson Victor on 10/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
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
                    self.tintColor = .white
                }
            }
        }
    }
}
