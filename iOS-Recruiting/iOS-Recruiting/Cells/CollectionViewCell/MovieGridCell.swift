//
//  MovieGridCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var heartIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!


    internal func configure(_ movie: Movie) {
        self.nameLabel.text = movie.title
        
        let isFavourite = movie.isFavourite ?? false
        
        self.heartIconImage.isHighlighted = isFavourite
        
        if let poster = movie.poster_path, let url = NetworkService.getURL(api: .imagesMovieDB, path: poster) {
            self.movieImage.setImage(url: url)
        }
    }
    
}

extension MovieGridCell: ReusableView, NibLoadableView {}
