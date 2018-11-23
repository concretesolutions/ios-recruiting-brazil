//
//  MoviesCollectionViewCell.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 14/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var OutletMovieImage: ReusableImageView!
    @IBOutlet weak var OutletMovieName: UILabel!
    @IBOutlet weak var OutletFavoriteButton: UIButton!
    
    // MARK: - Properties
    
    var movie: Movie? {
        didSet {
            self.setupMovieImage()
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    func setup(movie: Movie) {
        self.movie = movie
        self.OutletMovieName.text = movie.title
    }
    
    func setupMovieImage() {
        if let imageUrl = self.movie?.imgUrl {
            self.OutletMovieImage.loadImageUsingUrlString(urlString: imageUrl)
        }
    }
}
