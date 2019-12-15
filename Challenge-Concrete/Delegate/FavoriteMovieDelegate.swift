//
//  AddFavoriteMovieDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 13/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

protocol FavoriteMovieDelegate: AnyObject {
    func didAdd(_ favoriteMovie: FavoriteMovie)
    func didRemove(favoriteMovieId: Int)
}
