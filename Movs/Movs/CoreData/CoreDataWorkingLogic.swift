//
//  CoreDataWorkingLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol CoreDataWorkingLogic {
    func create(movie: Movie)
    func fetchFavoriteMovies() -> [Movie]
    func delete(movie: Movie)
    func deleteAll()
    func favoriteMovie(movie: Movie)
    func isFavorite(id: Int) -> Bool
}
