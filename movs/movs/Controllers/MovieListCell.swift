//
//  MovieListCell.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit
import Kingfisher

final class MovieListCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var favouriteButton: UIButton!

    // MARK: - Properties
    private var movie: Movie! {
        didSet {
			let imageUrl = Constants.Integration.imageurl + movie.imagePath

            movieImageView.kf.setImage(with: URL(string: imageUrl))
            // fav button
        }
    }
}

// MARK: - Public
extension MovieListCell {
    func setup(movie: Movie) {
		self.movie = movie
    }
}
