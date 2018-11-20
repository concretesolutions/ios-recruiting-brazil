//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    
    var movie: Movie!
    
    // MARK: - Util functions
    
    func set(movie: Movie) {
        self.movie = movie
        self.title.text = movie.title
        if let posterImage = movie.posterImage {
            self.poster.image = posterImage
        } else {
            self.poster.showActivityIndicator()
            APIDataManager.readPosterImage(withCode: movie.posterPath ?? "") { image in
                DispatchQueue.main.async {
                    self.poster.hideActivityIndicator()
                    movie.posterImage = image ?? UIImage(named: "Movies")
                    self.poster.image = movie.posterImage
                }
            }
        }
    }
    
    func set(image: UIImage) {
        self.poster.hideActivityIndicator()
        self.poster.image = image
    }
    
}
