//
//  MovieCollectionViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var outletPosterImageView: UIImageView!
    @IBOutlet weak var outletActivity: UIActivityIndicatorView!
    @IBOutlet weak var outletGradientView: UIView!
    @IBOutlet weak var outletFilmNameLabel: UILabel!
    @IBOutlet weak var outletFavoriteImageView: UIImageView!
    
    
    func setup(film: Film){
        self.outletFilmNameLabel.text = film.title
    }
}
