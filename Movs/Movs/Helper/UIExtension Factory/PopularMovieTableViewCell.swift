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
    @IBOutlet weak var moviePosition: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    
    func configureCellWith(data: ListMovies.ViewModel.PopularMoviesFormatted, position: Int, isFavorite: Bool) {
        movieIdentifier = data.id
        movieTitle.text = data.title
        movieDescription.text = data.overview
        favoriteIcon.image = isFavorite ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_gray_icon")
        movieImageView.kf.setImage(with: data.posterPath)
        if position != 0 {
            moviePosition.text = String(position) + "º"         
        } else {
            moviePosition.text = ""
        }
        loading.isHidden = true
    }
    
    func loadingCell(){
        loading.isHidden = false
        loading.startAnimating()
    }
    
}
