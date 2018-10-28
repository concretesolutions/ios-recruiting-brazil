//
//  ManagerMovies.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class ManagerMovies: UIViewController {

    var favorites = [Movie]()
    var movies = [Movie]()
    
    init() {
        super.init(nibName: "", bundle: nil)
        self.setupMovies()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            dispatchPrecondition(condition: .onQueue(.main))
            if let _movies = moviesJSON {
            } else {
                print("Nothing movies")
            }
        })
    }
    
    func transformDictionary(moviesJSON: [Dictionary<String,Any>]) {
        for movie in moviesJSON {
            movies.append(Movie(_movieNP: movie))
        }
    }
}

extension ManagerMovies: FavoriteMovieDelegate {
    
    func setFavorite(movie: Movie) {
        self.favorites.append(movie)
    }
    
    func removeFavorite(movie: Movie) {
        let index = getIndexFavorite(movie: movie)
        if  index != -1{
            self.favorites.remove(at: index)
        }
    }
    
    private func getIndexFavorite(movie: Movie) -> Int {
        for (index, _movie) in favorites.enumerated() {
            let _id = _movie.movie?.id
            let id = movie.movie?.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}
extension ManagerMovies: SendFavoritesFilmesDelegate {
    func send(favorites: [Movie]) {
        self.favorites = favorites
    }
}
