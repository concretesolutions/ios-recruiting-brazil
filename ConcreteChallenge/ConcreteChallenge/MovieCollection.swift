//
//  MovieCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

protocol MovieCollectionDelegate {
    func reload()
}

class MovieColletion {
    
    var delegate: MovieCollectionDelegate?
    
    private var movies = [Movie]()
    private var favoriteMovies: [FavoriteMovie] {
        get {
            return CoreDataHelper.retrieveFavoriteMovies()
        }
    }
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
    func getFavorites() -> [Movie] {
        var movies = [Movie]()
        
        for favorite in favoriteMovies {
            movies.append(contentsOf: self.movies.filter { $0.id == Int(favorite.id) })
        }
        
        return movies
    }
    
    func movie(at index: Int) -> Movie? {
        return movies[safeIndex: index]
    }
    
    func requestMovies() {
        ServiceLayer.request(router: .getMovies) { (result: Result<MoviesResponse, Error>) in
            switch result {
            case .success(let response):
                self.movies.append(contentsOf: response.results)
                self.delegate?.reload()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateState(for movie: Movie) {
        if let movie = CoreDataHelper.favoriteMovie(for: movie.id) {
            CoreDataHelper.delete(favoriteMovie: movie)
        } else {
            let favoriteMovie = CoreDataHelper.newFavoriteMovie()
            
            favoriteMovie.id = Int64(movie.id)
            favoriteMovie.title = movie.title
            favoriteMovie.releaseDate = movie.releaseDate
            favoriteMovie.overview = movie.overview
            favoriteMovie.voteAverage = movie.voteAverage
            
            CoreDataHelper.save()
        }
    }
}
