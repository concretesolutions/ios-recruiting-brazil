//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        let favoriteImage = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }

}
