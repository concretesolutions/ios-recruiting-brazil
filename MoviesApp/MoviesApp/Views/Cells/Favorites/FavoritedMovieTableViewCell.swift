//
//  FavoritedMovieTableViewCell.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

class FavoritedMovieTableViewCell: UITableViewCell {
    class var reuseIdentifier: String {
        return "FavoritedMovieTableViewCell"
    }
    
    class var nib: UINib {
        return UINib(nibName: reuseIdentifier, bundle: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.sd_cancelCurrentAnimationImagesLoad()
    }

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func set(_ movie: Movie) {
        yearLabel.text = movie.releaseDate.yearString
        descriptionLabel.text = movie.overview
        titleLabel.text = movie.title
        pictureImageView
            .sd_setImage(with: ImageServiceConfig
                .defaultURL(with: movie.posterPath,
                            width: Int(self.pictureImageView.frame.size.width))) { (image, _, _, _) in
            if let image = image {
                self.pictureImageView.image = image.proportionalResized(width: self.pictureImageView.frame.size.width)
            }
        }
    }

}
