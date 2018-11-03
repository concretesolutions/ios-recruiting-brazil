//
//  FavoritesInteractor.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FavoritesInteractor: FavoritesBussinessLogic {
    var presenter: FavoritesPresentationLogic!
    var favoritesWorker: FavoritesWorkingLogic!
    var coreDataWorker: CoreDataWorkingLogic
    
    var movies: [Movie] = []
    
    init() {
        coreDataWorker = CoreDataWorker()
        favoritesWorker = FavoritesWorker()
    }
    
    func fetchFavoritesMovies(request: Favorites.Request) {
        let result = coreDataWorker.fetchFavoriteMovies()
        self.movies = result
        presentMovies(movies: result)
    }
    
    func prepareFilteredMovies(request: Favorites.Request.Filtered) {
        self.movies = request.movies
        presentMovies(movies: request.movies)
    }
    
    func filterMovies(request: Favorites.Request.RequestMovie) {
        if request.title == "" {
            presentMovies(movies: movies)
            return
        }
        
        let result = movies.filter { (movie) -> Bool in
            movie.title.lowercased().contains(request.title.lowercased())
        }
        presentMovies(movies: result)
    }
    
    func unfavoriteMovie(at index: Int) {
        let movie = movies.remove(at: index)
        coreDataWorker.delete(movie: movie)
        presentMovies(movies: movies)
    }
    
    func presentMovies(movies: [Movie]) {
        let movies = movies.map { (movie) -> Favorites.FavoritesMovie in
            let imageView = favoritesWorker.fetchPoster(posterPath: movie.posterPath)
            
            return Favorites.FavoritesMovie(title: movie.title, year: movie.releaseDate,
                                   overview: movie.overview, imageView: imageView)
        }
        let response = Favorites.Response(movies: movies)
        presenter.present(response: response)
    }
}
