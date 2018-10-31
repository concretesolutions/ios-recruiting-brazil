//
//  FavoriteMoviesTableViewCell.swift
//  Movs
//
//  Created by Maisa on 28/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit
import Kingfisher

class FavoriteMoviesTableViewCell: UITableViewCell {
    
    var movieRawData: FavoriteMoviesModel.FavoriteMovie?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieImageView: UIImageViewMovieCard!
    
    func configureCellWith(data: FavoriteMoviesModel.FavoriteMovie) {
        self.movieRawData = data
        movieTitle.text = data.title
        movieDescription.text = data.overview
        movieImageView.kf.setImage(with: data.posterPath)
        movieYear.text = data.year
    }
    
}
