//
//  MoviePersistenceMock.swift
//  MovTests
//
//  Created by Miguel Nery on 26/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov


class MoviePersistenceMock: FavoriteMoviesPersistence {
    
    func isFavorite(_ movie: Movie) -> Bool {
        return false
    }
}
