//
//  FavoriteMovies.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 27/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit

protocol FavoriteMoviesProtocol {
    func handleMovieFavorite(movie: Movie)
    func changeButtonImage(button: UIButton, movie: Movie) 
}
