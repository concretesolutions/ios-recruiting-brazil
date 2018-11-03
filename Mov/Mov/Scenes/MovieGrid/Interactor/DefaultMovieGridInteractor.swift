//
//  TMDBMovieListInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


final class DefaultMovieGridInteractor {
    
    let presenter: MovieGridPresenter
    
    private let movieFetcher: MovieFetcher
    
    private let persistence: FavoritesPersistence

    private var favorites = Set<Movie>()
    
    private(set) var movies = [Movie]()
    
    private(set) var page = 0
    
    
    init(presenter: MovieGridPresenter, movieFetcher: MovieFetcher, persistence: FavoritesPersistence) {
        self.presenter = presenter
        self.movieFetcher = movieFetcher
        self.persistence = persistence
    }
    
    private func movieGridUnits(from movies: [Movie]) -> [MovieGridUnit] {
        return movies.map { movie in
            let isFavorite = self.favorites.contains(movie)
            return MovieGridUnit(from: movie, isFavorite: isFavorite)
        }
    }
    
    func movie(at index: Int) -> Movie? { return self.movies[safe: index] }
}

extension DefaultMovieGridInteractor: MovieGridInteractor {
    
    func fetchMovieList(page: Int) {
        // fetch updated favorites
        do {
            self.favorites = try self.persistence.fetchFavorites()
        } catch {/*do nothing*/}
        
        guard (movies.isEmpty || page > self.page) else {
            self.presenter.present(movies: movieGridUnits(from: self.movies))
            return
        }

        // fetch movies
        self.movieFetcher.fetchPopularMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.page = page
                self.movies.append(contentsOf: movies)
                self.presenter.present(movies: self.movieGridUnits(from: self.movies))
            case .failure:
                self.presenter.presentNetworkError()
            }
        }
    }
    
    func toggleFavoriteMovie(at index: Int) {
        if let movie = self.movies[safe: index] {
            do {
                try self.persistence.toggleFavorite(movie: movie)
                self.fetchMovieList(page: self.page)
            } catch {
                self.presenter.presentGenericError()
            }
        } else {/*do nothing*/}
    }
    
    func filterMoviesBy(string: String) {
        guard !string.isEmpty else {
            self.presenter.present(movies: movieGridUnits(from: self.movies))
            return
        }
        let candidates = self.movies.filter { movie in movie.title.contains(string) }
        
        if candidates.isEmpty {
            self.presenter.presentNoResultsFound(for: string)
        } else {
            self.presenter.present(movies: movieGridUnits(from: candidates))
        }
    }
}
