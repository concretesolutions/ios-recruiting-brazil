//
//  FavoriteMoviePresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 27/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

class FavoriteMoviePresenter: MoviePresenter {
    
    override init() {
        super.init()
    }
    
    override func loadCollectionView(page: Int? = nil) {
        let favoriteMovies = LocalData.object.getAllFavoriteMovies()
        var moviesHelper: [Movie] = []
        moviesHelper.append(contentsOf: favoriteMovies.values)
        self.movies = moviesHelper
        self.numberOfMovies = movies.count
        self.movieView?.reloadData()
    }
}
