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
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Properties
    private let favoriteDataPresenter = FavoritesDataPresenter.shared
    private var movie: Movie! {
        didSet {
			let imageUrl = Constants.Integration.imageurl + movie.imagePath

            movieImageView.kf.setImage(with: URL(string: imageUrl))

            let isFavorite = favoriteDataPresenter.isFavorite(movie.movieId)
            favoriteButton.tintColor = isFavorite ? .yellowConcrete : .white
        }
    }
}

// MARK: - Public
extension MovieListCell {
    func setup(movie: Movie) {
		self.movie = movie
    }
}

// MARK: - Lifecycle
extension MovieListCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.accessibilityIdentifier = Constants.Accessibility.favorite
    }
}

// MARK: - IBAction
extension MovieListCell {
    @IBAction private func tappedFavorite(_ sender: Any) {
		favoriteDataPresenter.favoritedAction(movie.movieId)

        let isFavorite = favoriteDataPresenter.isFavorite(movie.movieId)
        favoriteButton.tintColor = isFavorite ? .yellowConcrete : .white
    }
}
