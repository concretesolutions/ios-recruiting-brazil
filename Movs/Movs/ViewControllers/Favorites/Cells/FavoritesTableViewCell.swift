//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    @IBOutlet weak var moviePicture: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieYear: UILabel!

    var presenter: FavoritesCellPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func setup(with movie: Movie) {
        movieTitle.text = movie.title
        movieDescription.text = movie.overview
        movieYear.text = movie.releaseDate

        presenter = FavoritesCellPresenter(view: self)
        presenter.onMovieSet(movie: movie)
    }
}

extension FavoritesTableViewCell: FavoriteCellItem {
    func moviesCellPresenter(presenter: FavoritesCellPresenter, didFetchImage image: UIImage) {
        guard let selfPresenter = self.presenter, selfPresenter === presenter else { return }
        moviePicture.image = image
    }
}
