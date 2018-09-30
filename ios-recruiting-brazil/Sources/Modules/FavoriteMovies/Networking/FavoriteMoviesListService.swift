//
//  FavoriteMoviesListService.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation

final class FavoriteMoviesListService {
    func fetchFavoreites() -> [MovieModel]? {
        return try? RealmWrapper
            .read(RLMMovieModel.self)
            .toArray()
            .map({ MovieModel(RLMMovieModel: $0)
        })
    }
}
