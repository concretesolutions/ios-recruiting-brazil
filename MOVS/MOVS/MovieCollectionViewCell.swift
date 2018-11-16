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
        self.outletActivity.startAnimating()
        DesignManager.gradient(toView: self.outletGradientView)
        DesignManager.applyShadow(toView: self.contentView)
        self.outletFilmNameLabel.text = film.title
        // TODO: - colocar o poster, parar o activity indicator, conferir se o filme é favorito
    }
}
