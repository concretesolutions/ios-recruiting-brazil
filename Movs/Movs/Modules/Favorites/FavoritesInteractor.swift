//
//  FavoritesInteractor.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoritesInteractor {
    
    // MARK: - VIPER
    var presenter: FavoritesPresenter?
    
    // MARK: - Parameters
    private var moviesVisible: [MovieLocal] = [] {
        didSet {
            self.presenter?.moviesFilterChanged()
        }
    }
    private var movies: [MovieLocal] = []
    
    init() {
    }
    
    // FROM PRESENTER
    
    func fetchFavoriteMovies() {
        self.movies = LocalManager.getMovies()
        self.moviesVisible = self.movies
    }
    
    func getTotalMovies() -> Int {
        return moviesVisible.count
    }
    
    func getMovie(at index: Int) -> MovieDetail {
        let storedMovie = moviesVisible[index]
        let movie = MovieDetail.init(adult: false, genres: nil, title: storedMovie.title!, release_date: storedMovie.year!, poster_path: storedMovie.image!, overview: storedMovie.overview!, homepage: nil, id: Int(storedMovie.id))
        return movie
    }
   
}
