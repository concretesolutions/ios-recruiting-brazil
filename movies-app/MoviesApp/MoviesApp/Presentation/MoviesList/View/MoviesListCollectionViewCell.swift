//
//  MoviesListCollectionViewCell.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit

class MoviesListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func instanceOfNib() -> UINib {
        return UINib(nibName: MoviesListCollectionViewCell.reusableIdentifier, bundle: Bundle.main)
    }
}
