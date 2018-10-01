//
//  FavoriteMoviesListService.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation

protocol FavoriteMoviesListServiceType {
    func fetchFavoreites() -> [MovieModel]?
    func remove(movie: MovieModel)
}

final class FavoriteMoviesListService: FavoriteMoviesListServiceType {
    func fetchFavoreites() -> [MovieModel]? {
        return try? RealmWrapper
            .read(RLMMovieModel.self)
            .toArray()
            .map({ MovieModel(RLMMovieModel: $0)
        })
    }
    
    func remove(movie: MovieModel) {
        _ = try? RealmWrapper.remove(RLMMovieModel.self, filter: "id = \(movie.id)")
    }
}
