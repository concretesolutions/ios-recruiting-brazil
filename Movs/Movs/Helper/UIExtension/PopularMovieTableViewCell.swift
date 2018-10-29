//
//  PopularMovieTableViewCell.swift
//  Movs
//
//  Created by Maisa on 24/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit
import Kingfisher

class PopularMovieTableViewCell: UITableViewCell {

    var movieIdentifier: Int?
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieImageView: UIImageViewMovieCard!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    
    func configureCellWith(data: ListMovies.ViewModel.PopularMoviesFormatted) {
        self.movieIdentifier = data.id
        self.movieTitle.text = data.title
        self.movieDescription.text = data.overview
        self.favoriteIcon.image = data.favoriteIcon
        self.movieImageView.kf.setImage(with: data.posterPath)
    }
    
}
