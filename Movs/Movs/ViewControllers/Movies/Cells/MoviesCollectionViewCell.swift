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

        presenter = MoviesCellPresenter(view: self)
        presenter.onMovieSet(movie: movie)
    }
}

extension MoviesCollectionViewCell: MovieCellItem {
    func moviesCellPresenter(presenter: MoviesCellPresenter, didFetchImage image: UIImage) {
        if let selfPresenter = self.presenter, selfPresenter === presenter {
            self.moviePicture.image = image
        }
    }
}
