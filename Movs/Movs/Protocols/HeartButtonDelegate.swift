//
//  PopularMovieCellDelegate.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

protocol HeartButtonDelegate: class {

    // MARK: - Tap handlers

    func didTapOnHeart(fromMovie movie: Movie)
}

extension HeartButtonDelegate {

    func didTapOnHeart(fromMovie movie: Movie) {
        if movie.isFavorite {
            DataProvider.shared.removeFavoriteMovie(movie)
        } else {
            DataProvider.shared.addFavoriteMovie(movie)
        }
    }
}
