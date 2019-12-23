//
//  MovieViewModelWithFavoriteOptions.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

/// Its a viewmodel of movies that also contains favorite options. Its used by views with "favorite button"(the movie detail and some cells)
protocol MovieViewModelWithFavoriteOptions: MovieViewModel {
    var needUpdateFavorite: ((_ faved: Bool) -> Void)? { get set}
    var favoritesNavigator: MovieViewModelWithFavoriteOptionsNavigator? { get set }
    
    func usedTappedToFavoriteMovie()
}

extension MovieViewModel {
    var withFavoriteOptions: MovieViewModelWithFavoriteOptions? {
        
        return MovieViewModelDecorator.searchDecorator(ofType: MovieViewModelWithFavoriteOptions.self, in: self)
    }
}
