//
//  FavoritesDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FavoritesDisplayLogic: class {
    /**
     Display favorites movies.
     
     - parameters:
         - viewModel: Data of the favorite movies to display.
     */
    func displayFavorites(viewModel: Favorites.ViewModel)
}
