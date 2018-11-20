//
//  MoviesInteractor.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesInteractor: MoviesUseCase {
    
    // MARK: - Properties
    
    var output: MoviesInteractorOutput!
    private var current: [Movie] = []
    
    // MARK: - MoviesUseCase protocol functions
    
    func readMoviesFor(page: Int) {
        APIDataManager.readPopularFor(page: page) {
            self.current.append(contentsOf: $0)
            self.output.didReadMoviesForPage(page, $0)
        }
    }
    
    func filterMoviesWith(name: String) {
        let filtered = self.current.filter { return $0.title.contains(name) }
        output.didFilterMoviesWithName(name, filtered)
    }
    
    func removeFilter() {
        output.didRemoveFilter(self.current)
    }
    
    func favorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.createFavoriteMovie(movie)
            ImageDataManager.saveImage(posterPath: movie.posterPath ?? "", image: movie.posterImage ?? UIImage())
        }
        movie.isFavorite = true
    }
    
    func unfavorite(movie: Movie) {
        DispatchQueue.main.async {
            MovieDataManager.deleteFavoriteMovie(withId: movie.id)
            ImageDataManager.deleteImage(withPosterPath: movie.posterPath ?? "")
        }
        movie.isFavorite = false
    }
    
}
