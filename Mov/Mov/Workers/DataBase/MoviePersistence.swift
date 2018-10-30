//
//  FavoriteMoviesPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

protocol MoviePersistence: class {
    
//    var pagesFetch: Int { get }
//    
//    var fetchedMovies: [Movie] { get set }
    
    func isFavorite(_ movie: Movie) -> Bool
}
