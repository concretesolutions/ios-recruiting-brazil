//
//  FavoriteMoviesPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol MoviePersistence {
    /**
     Tell if ```movie``` is marked as favorite.
     - Parameter movie: movie to be evaluated.
     */
    func isFavorite(_ movie: Movie) -> Bool
}
