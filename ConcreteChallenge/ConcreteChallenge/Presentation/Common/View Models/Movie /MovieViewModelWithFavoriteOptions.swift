//
//  MovieViewModelWithFavoriteOptions.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol MovieViewModelWithFavoriteOptions: MovieViewModel {
    var needUpdateFavorite: ((_ faved: Bool) -> Void)? { get set}
    
    func usedTappedToFavoriteMovie()
}

class DefaultMovieViewModelWithFavoriteOptions: MovieViewModelDecorator, MovieViewModelWithFavoriteOptions {
    var needUpdateFavorite: ((Bool) -> Void)? {
        didSet {
            self.needUpdateFavorite?(self.isFaved ?? false)
        }
    }
    
    private var isFaved: Bool? {
        didSet {
            guard let isFaved = self.isFaved else {
                return
            }
            self.needUpdateFavorite?(isFaved)
        }
    }
    private let favoriteHandlerRepository: FavoriteMovieHandlerRepository
    
    init(favoriteHandlerRepository: FavoriteMovieHandlerRepository, decorated: MovieViewModelWithData) {
        self.favoriteHandlerRepository = favoriteHandlerRepository
        super.init(decorated)
        
        getFavoriteInformation()
    }
    
    func usedTappedToFavoriteMovie() {
        guard let isFaved = self.isFaved else {
            return
        }
        
        guard isFaved else {
            addToFavorites()
            return
        }
    
        removeFavorite()
    }
    
    private func getFavoriteInformation() {
        favoriteHandlerRepository.movieIsFavorite(movie) { (result) in
            switch result {
            case .success(let isFaved):
                self.isFaved = isFaved
            case .failure:
                self.isFaved = false
            }
        }
    }
    
    private func addToFavorites() {
        favoriteHandlerRepository.addMovieToFavorite(movie) { (result) in
            switch result {
            case .success:
                self.isFaved = true
            default:
                break
            }
        }
    }
    
    private func removeFavorite() {
        favoriteHandlerRepository.removeMovieFromFavorite(movieID: movie.id) { (result) in
            switch result {
            case .success:
                self.isFaved = false
            default:
                break
            }
        }
    }
}
