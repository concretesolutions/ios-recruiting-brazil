//
//  MockFavoriteMoviesListService.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation

@testable import ios_recruiting_brazil

final class MockFavoriteMoviesListService: FavoriteMoviesListServiceType {
    
    var callRemoveMethod = false
    var simuleSccuss = true
    
    var movies = [MovieModel(id: 272,
                             posterPath: "/65JWXDCAfwHhJKnDwRnEgVB411X.jpg",
                             title: "Batman Begins",
                             desc: "Batman Begins",
                             releaseDate: "2005-06-10",
                             releaseYear: "2005",
                             genders: [GenderModel(id: 28)],
                             isFavorite: true),
                  MovieModel(id: 364,
                             posterPath: "/jX5THE1yW3zTdeD9dupcIyQvKiG.jpg",
                             title: "Batman Returns",
                             desc: "Batman Returns",
                             releaseDate: "1992-06-19",
                             releaseYear: "1992",
                             genders: [GenderModel(id: 28)],
                             isFavorite: true)]
    
    func fetchFavoreites() -> [MovieModel]? {
        if simuleSccuss {
            return self.movies
        } else {
            return nil
        }
    }
    
    func remove(movie: MovieModel) {
        self.callRemoveMethod = true
    }
    
    
}
