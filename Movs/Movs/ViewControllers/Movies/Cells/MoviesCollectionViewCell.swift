//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

class MoviesCollectionViewCell: UICollectionViewCell {

    @IBOutlet var favoriteButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var moviePicture: UIImageView!

    private var movie: Movie?
    private var presenter: MoviesCellPresenter!

    override func awakeFromNib() {
        super.awakeFromNib()
        let favoriteImage = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(favoriteImage, for: .normal)

        moviePicture.image = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        moviePicture.image = nil
    }

    func setup(with movie: Movie) {
        self.movie = movie
        self.titleLabel.text = movie.title
        setFavorite(to: movie.isFavorited)

        presenter = MoviesCellPresenter(view: self)
        presenter.onMovieSet(movie: movie)
    }

    @IBAction func onFavoriteButtonTapped(_ sender: UIButton) {
        guard let movie = self.movie else { return }
        presenter.onFavoriteAction(movie: movie)
    }
}

extension MoviesCollectionViewCell: MovieCellItem {
    func moviesCellPresenter(presenter: MoviesCellPresenter, didFetchImage image: UIImage) {
        if let selfPresenter = self.presenter, selfPresenter === presenter {
            self.moviePicture.image = image
        }
    }

    func setFavorite(to favorite: Bool) {
        if !favorite {
            let favoriteImage = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
            favoriteButton.setImage(favoriteImage, for: .normal)
        } else {
            let unfavoriteImage = UIImage(named: "buttonUnfavorite")?.withRenderingMode(.alwaysTemplate)
            favoriteButton.setImage(unfavoriteImage, for: .normal)
        }
    }
}
