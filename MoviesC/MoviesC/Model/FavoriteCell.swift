//
//  FavoriteCell.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Nuke

class FavoriteCell: UITableViewCell {
    
    var movie: Detail? {
        didSet {
            guard let movie = movie else { return }
            titleLabel.text = movie.title
            overviewLabel.text = movie.overview
            dateLabel.setYear(from: movie.releaseDate)
            overviewLabel.text = movie.overview
            let url = MovieAPIClient.imageURL(with: movie.posterPath)
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.5)), into: posterImageView)
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            posterImageView.applyDropshadow()
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
}
