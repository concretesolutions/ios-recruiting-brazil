//
//  FavoriteListCell.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit
import SwipeCellKit
import Kingfisher

final class FavoriteListCell: SwipeTableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    // MARK: - Properties
    private var movie: Movie! {
        didSet {
            let imageUrl = Constants.Integration.imageurl + movie.imagePath
            movieImageView.kf.setImage(with: URL(string: imageUrl))

            titleLabel.text = movie.name
            yearLabel.text = String(movie.releaseDate.prefix(4))
            descriptionLabel.text = movie.description
        }
    }
}

// MARK: - Public
extension FavoriteListCell {
    func setup(movie: Movie) {
        self.movie = movie
    }
}
