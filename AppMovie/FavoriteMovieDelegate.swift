//
//  DelegateSetFavorite.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import Foundation
protocol FavoriteMovieDelegate {
    func setFavorite(movie: Movie)
    func removeFavorite(movie: Movie)
}

protocol ReceiveFavoriteDelegate {
    func receive(favorites: [Movie])
}
