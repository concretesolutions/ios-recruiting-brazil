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
    
    private let favoriteEmpty = UIImage(named: "favorite_gray_icon")
    private let favoriteFull = UIImage(named: "favorite_full_icon")
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UITextView!
    @IBOutlet weak var movieImageView: UIImageViewMovieCard!
    @IBOutlet weak var favoriteButton: UIButton!
    
    func configureCellWith(data: PopularMovie) {
        self.movieIdentifier = data.id
        self.movieTitle.text = data.title
        self.movieDescription.text = data.overview
        self.favoriteButton.imageView?.image = data.isFavorite == true ? favoriteFull : favoriteEmpty
        let posterPath = data.posterPath
        let url = URL(string: posterPath)
        movieImageView.kf.setImage(with: url)
    }
    
}
