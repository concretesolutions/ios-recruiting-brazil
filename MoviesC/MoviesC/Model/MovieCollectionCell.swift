//
//  MovieCollectionCell.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Nuke

class MovieCollectionCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            let url = MovieAPIClient.imageURL(with: movie.posterPath)
            // Use Nuke to make the download request for images. It also caches the downloaded images and manages requests asynchronously
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.5)), into: posterImageView)
            titleLabel.text = movie.title
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.applyDropshadow()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
    }
    
}
