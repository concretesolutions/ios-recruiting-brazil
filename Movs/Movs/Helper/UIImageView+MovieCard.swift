//
//  UIImageView+MovieCard.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

class UIImageViewMovieCard: UIImageView {
    
    private let cornerRadius: CGFloat = 2.0
    
    override func layoutSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        
    }
}
