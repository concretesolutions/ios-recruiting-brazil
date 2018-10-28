//
//  TMDBMovieListInteractor.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


final class DefaultMovieGridInteractor {
    
    var presenter: MovieGridPresenter!
    
    private let movieFetcher: MovieFetcher
    
    private let moviePersistence: MoviePersistence
    
    init(movieFetcher: MovieFetcher, moviePersistence: MoviePersistence) {
        self.movieFetcher = movieFetcher
        self.moviePersistence = moviePersistence
    }
    
    private func buildMovieGridUnits(from movies: [Movie]) -> [MovieGridUnit] {
        return movies.map { movie in
            let isFavorite = self.moviePersistence.isFavorite(movie)
            return MovieGridUnit(title: movie.title, posterPath: movie.posterPath, isFavorite: isFavorite)
        }
    }
}

extension DefaultMovieGridInteractor: MovieGridInteractor {
    
    func fetchMovieList(page: Int) {
        self.movieFetcher.fetchPopularMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            self.presenter.presentNetworkError()
            
            switch result {
            case .success(let movies):
                
                self.presenter.present(movies: self.buildMovieGridUnits(from: movies))
                
            case .failure:
                self.presenter.presentNetworkError()
            }
        }
    }
    
}
