//
//  MovieCollectionViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 15/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var film: ResponseFilm?
    
    @IBOutlet weak var outletPosterImageView: UIImageView!
    @IBOutlet weak var outletActivity: UIActivityIndicatorView!
    @IBOutlet weak var outletGradientView: UIView!
    @IBOutlet weak var outletFilmNameLabel: UILabel!
    @IBOutlet weak var outletFavoriteImageView: UIImageView!
    
    
    func setup(film: ResponseFilm){
        self.film = film
        DesignManager.gradient(toView: self.outletGradientView)
        DesignManager.applyShadow(toView: self)
        self.outletActivity.alpha = 1
        self.outletFilmNameLabel.text = film.title
        self.outletPosterImageView.getPoster(forFilm: film, andActivity: self.outletActivity)
        
        //TODO: - check if film is favorite
    }
}
