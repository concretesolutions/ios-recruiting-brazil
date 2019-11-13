//
//  FavoriteController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 07/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol FavoriteControllerDelegate {
    func showMovies(movies: [MovieSave])
}

class FavoriteController {
    
    var dataManager = MovieDataManager()
    var delegate: FavoriteControllerDelegate?

    func getMovies() {
        dataManager.loadMovie { (arrayMovie) in
            delegate?.showMovies(movies: arrayMovie)
        }
    }
    
    func delete(movie: MovieSave, completion: (Bool) -> Void) {
        dataManager.delete(id: movie.objectID) { (success) in
            if success {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
}
