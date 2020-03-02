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
        if favoriteMovies.count == 0 {
            self.movieView?.showError(imageName: Constants.ErrorValues.favoriteImageName, text: Constants.ErrorValues.favoriteMovieText)
            self.movieView?.reloadData()
        }
    }
    
    func showMovieDetails(movie index: Int, from data: [Movie]) {
        let selectedMovie = data[index]
        delegate?.selectedMovie(movie: selectedMovie)
    }
}
