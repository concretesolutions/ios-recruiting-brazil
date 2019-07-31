//
//  FavoriteMoviesInteractor.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

class FavoriteMoviesInteractor: FavoriteMoviesUseCase {
    
    //MARK: - Contract Properties
    weak var output: FavoriteMoviesInteractorOutput!
    
    //MARK: - Contract Functions
    func fetchFavoriteMovies() {
        let movies = UserSaves.favoriteMovies
        let posters = UserSaves.posters
        
        output.fetchedFavoriteMovies(movies, posters: posters)
        
//        if let movies = LocalDataSaving.retrieve(forKey: "FavoredMovie") as? [MovieEntity] {
//            output.fetchedFavoriteMovies(movies)
//        }
//        else {
//            output.fetchedFavoriteMoviesFailed()
//        }
        
    }
}
