//
//  FavoriteMovieInteractor.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class FavoriteMoviesInteractor: FavoriteMoviesInteractorInput {
    
    // MARK: - Properties
    var output: FavoriteMoviesInteractorOutput!
    
    // MARK: - FavoriteMoviesInteractorInput functions
    func getFavoriteMovies() {
        FavoriteMovieCoreDataManager.getFavoriteMovies { (status) in
            if status == Status.success {
                self.output.didGetFavoriteMovies(favoriteMovies: FavoriteMovieCoreDataManager.favoriteMovies)
            }
        }
    }
}
