//
//  MovieCollectionViewCell.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var favoriteIconImageView: UIImageView!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                self.movieTitleLabel.text = movie.title
            }
        }
    }
    
}
