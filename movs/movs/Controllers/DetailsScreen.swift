//
//  DetailsScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit
import Kingfisher

protocol DetailsScreenDelegate: class {
    func changedFavoriteStatus()
}

final class DetailsScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var favoriteButton: UIButton!

    // MARK: - Properties
    private var movie: Movie!
    private let dataPresenter = MoviesDataPresenter()
    private let favoritesDataPresenter = FavoritesDataPresenter.shared
    private var genres = [Genre]()

    // MARK: - Delegate
    weak var delegate: DetailsScreenDelegate?
}

// MARK: - Public
extension DetailsScreen {
    func setup(movie: Movie) {
        self.movie = movie
    }
}

// MARK: - Lifecycle
extension DetailsScreen {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let imageUrl = URL(string: Constants.Integration.imageurl + movie.imagePath)
        movieImageView.kf.setImage(with: imageUrl)

        titleLabel.text = movie.name
        yearLabel.text = String(movie.releaseDate.prefix(4))
        descriptionTextView.text = movie.description

        let isFavorite = favoritesDataPresenter.isFavorite(movie.movieId)
        favoriteButton.tintColor = isFavorite ? .yellowConcrete : .lightGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
		fetchGenres()
    }
}

// MARK: - Private
extension DetailsScreen {
    private func fetchGenres() {
        dataPresenter.getGenres(completion: { [weak self] genres in
            guard let `self` = self else { return }
            self.genres = genres
            self.setupGenres()
        }) {
            // TO DO
        }
    }

    private func setupGenres() {
		var genreString = ""
        movie.genres.forEach { genreId in
            let genreName = genres.first(where: { genre -> Bool in
                return genre.identifier == genreId
            })?.name

            genreString.append(genreName!)
            genreString.append(", ")
        }

		genreString.removeLast(2)
        genreLabel.text = genreString
    }
}

// MARK: - IBActions
extension DetailsScreen {
    @IBAction private func tappedFavorite(_ sender: Any) {
        favoritesDataPresenter.favoritedAction(movie.movieId)

        let isFavorite = favoritesDataPresenter.isFavorite(movie.movieId)
        favoriteButton.tintColor = isFavorite ? .yellowConcrete : .lightGray

		delegate?.changedFavoriteStatus()
    }
}
