//
//  MovieMainHeaderCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class MovieMainHeaderCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var favouriteIconButton: UIButton!
    
    internal func configure(_ movie: Movie?) {
        self.nameLabel.text = movie?.original_title
        
        if let poster = movie?.poster_path, let url = NetworkService.getURL(api: .imagesMovieDB, path: poster) {
            self.posterImageView.setImage(url: url)
        }
        
        self.favouriteIconButton.isHighlighted = movie?.isFavourite ?? false
    }
}


extension MovieMainHeaderCell: ReusableView, NibLoadableView {}
