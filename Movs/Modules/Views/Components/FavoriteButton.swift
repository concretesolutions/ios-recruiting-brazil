//
//  FavoriteButton.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class FavoriteButton: UIButton {
    
    var favorited: Bool = false
    
    // MARK: - Initializers and Deinitializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.tintColor = .lightGray
        self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 3.0, bottom: 5.0, right: 5.0)
    }
    
    public func setFavorited(_ state: Bool) {
        if state == true {
            self.tintColor = .red
        } else {
            self.tintColor = .lightGray
        }
        
        self.favorited = state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
