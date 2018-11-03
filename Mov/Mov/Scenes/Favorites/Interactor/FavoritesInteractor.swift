//
//  FavoritesInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol FavoritesInteractor: MovieInteractor {
    func fetchFavorites()
    func toggleFavoriteMovie(at index: Int)
}
