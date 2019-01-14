//
//  FavoriteMoviesViewModel.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/13/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class FavoriteMoviesViewModel {
    var controller: FavoriteMoviesViewController?
    let sharedDBManager = DBManager.shared
    var favoriteMoviesArray = [MovieModel]()
    
    init(viewController: FavoriteMoviesViewController) {
        self.controller = viewController
        self.sharedDBManager.startDB()
        updateFavoriteMovies()
    }
    
    func updateFavoriteMovies() {
        sharedDBManager.getFavorites { (newFavoriteMoviesArray) in
            self.favoriteMoviesArray = newFavoriteMoviesArray
            self.favoriteMoviesArray.sort(by: {$0.title < $1.title})
            self.controller?.didUpdateFavoriteMovies()
        }
    }
    
    func remove(fromFavorites movie: MovieModel){
        self.sharedDBManager.removeFromFavorites(movie: movie)
        if let indexOfMovie = self.favoriteMoviesArray.index(of: movie){
            self.favoriteMoviesArray.remove(at: indexOfMovie)
        }
    }
    
    func verifyIfFavoritesIsUpdated(){
        let countOfFavoritesInDB = sharedDBManager.getFavoritesQuantity()
        if(countOfFavoritesInDB != favoriteMoviesArray.count){
            updateFavoriteMovies()
        }
    }
}
