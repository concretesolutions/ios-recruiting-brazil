//
//  TMDBMovieListInteractor.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


final class DefaultMovieGridInteractor {
    
    private let presenter: MovieGridPresenter
    
    private let movieFetcher: MovieFetcher
    
    init(presenter: MovieGridPresenter, movieFetcher: MovieFetcher) {
        self.presenter = presenter
        self.movieFetcher = movieFetcher
    }
}

extension DefaultMovieGridInteractor: MovieGridInteractor {
    
    func fetchMovieList() {
        if let movies = self.movieFetcher.fetchMovies() {
            self.presenter.present(movies: movies)
        } else {
            self.presenter.presentNetworkError()
        }
    }
    
}
