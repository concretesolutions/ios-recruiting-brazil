//
//  FavoritesMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteMoviesMiddleDelegate: class {
    func favoritesFetched()
    func savedMovie()
}

class FavoriteMoviesMiddle {
    
    let favoriteMovies = FavoriteMovies()
    var favoritesFetched: [FavoriteMovies] = []
    weak var delegate: FavoriteMoviesMiddleDelegate?
    
    init(delegate: FavoriteMoviesMiddleDelegate) {
        self.delegate = delegate
    }
    
    func movieData(at index: Int) -> FavoriteMovies {
        return favoritesFetched[index]
    }
    
    func fetchFavorites() {
        favoriteMovies.fetch()
        favoritesFetched = favoriteMovies.fetchedResultsController.fetchedObjects ?? []
        delegate?.favoritesFetched()
    }
    
    func save(movie: FavoriteMovies) {
        favoriteMovies.save(movie: movie)
        delegate?.savedMovie()
    }
    
}
