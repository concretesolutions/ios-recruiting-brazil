//
//  FavoriteMoviesInteractor.swift
//  ConcreteChallenge_BrunoChagas
//
//  Created by Bruno Chagas on 25/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import UIKit

final class FavoriteMoviesInteractor {
    
    //MARK: - Contract Properties
    weak var output: FavoriteMoviesInteractorOutput!
    
    //MARK: - Properties
    let bank = UserSaves()
}

//MARK: - Contract Functions
extension FavoriteMoviesInteractor: FavoriteMoviesUseCase {
    
    func fetchFavoriteMovies() {
        let movies = bank.getAllFavoriteMovies()
        let posters = bank.getAllPosters()
        
        output.fetchedFavoriteMovies(movies, posters: posters)
    }
    
    func removeFavoriteMovie(movie: MovieEntity, withPoster: Bool) {
        bank.remove(movie: movie.id!, withPoster: withPoster)
    }

}
