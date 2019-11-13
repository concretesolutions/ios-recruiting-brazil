//
//  FavoriteController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol FavoriteControllerDelegate {
    func showMovies(movies: [Movie])
}

class FavoriteController {
    
    var dataManager = MovieDataManager()
    var delegate: FavoriteControllerDelegate?
    
    func getMovies() {
        var movies:[Movie] = []
        dataManager.loadMovie { (arrayMovie) in
            arrayMovie.forEach { (movie) in
                movies.append(Movie(movie: movie))
            }
            delegate?.showMovies(movies: movies)
        }
    }
    
    func delete(movie: Movie, completion: (Bool) -> Void) {
        var movies:[MovieData] = []
        dataManager.loadMovie { (moviesData) in
            movies = moviesData.filter({$0.id == Int64(movie.id)})
        }
        if let movieSelected = movies.first {
            dataManager.delete(id: movieSelected.objectID) { (success) in
                if success {
                    completion(true)
                    return
                }
                completion(false)
            }
        }
    }
    
}
