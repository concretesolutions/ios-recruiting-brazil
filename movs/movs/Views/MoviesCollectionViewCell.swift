//
//  MoviesCollectionViewCell.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.containerView.backgroundColor = .darkGray
        self.containerView.roundedCorners()
        self.containerView.shadow()
    }

}
