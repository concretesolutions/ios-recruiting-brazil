//
//  FavoriteButton.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

enum FavoriteButtonType {
    case favorite
    case unfavorite
}

protocol FavoriteButtonDelegate: class {
    func click()
}

class FavoriteButton: UIButton {
    var type: FavoriteButtonType! {
        didSet {
            let imageName: String = self.type == .favorite ? "heart.fill" : "heart"
            
            self.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    weak var delegate: FavoriteButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        self.tintColor = .white
        addTarget(nil, action: #selector(click), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click() {
        delegate?.click()
    }
}
