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
            let imageColor: UIColor = self.type == .favorite ? .systemYellow : .secondarySystemFill
            
            self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.imageView?.tintColor = imageColor
        }
    }
    
    weak var delegate: FavoriteButtonDelegate?
    
    init() {
        super.init(frame: .zero)
        addTarget(nil, action: #selector(click), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click() {
        delegate?.click()
    }
}
