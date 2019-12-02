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

class FavoriteButton: UIButton {
    var type: FavoriteButtonType! {
        didSet {
            let imageColor: UIColor = self.type == .favorite ? .systemYellow : .secondarySystemFill
            
            self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.imageView?.tintColor = imageColor
        }
    }
    
    convenience init(type: FavoriteButtonType) {
        self.init(frame: .zero)
        
        self.type = type
    }
}
