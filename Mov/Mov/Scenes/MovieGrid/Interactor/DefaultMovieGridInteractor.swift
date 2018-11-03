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
    
    private(set) var fetchedMovies = [Movie]()

    private(set) var fetchedPages = 0
    
    private var favorites = Set<Movie>()
    
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
    
    func movie(at index: Int) -> Movie? { return self.fetchedMovies[safe: index] }
}

extension DefaultMovieGridInteractor: MovieGridInteractor {
    
    func fetchMovieList(page: Int) {
        // fetch updated favorites
        do {
            self.favorites = try self.persistence.fetchFavorites()
        } catch {
            self.presenter.presentFavoritesError()
        }
        
        // no need to fetch movies again if requested page was already fetched
        guard page > fetchedPages else {
            self.presenter.present(movies: movieGridUnits(from: self.fetchedMovies))
            return
        }

        // fetch movies
        self.movieFetcher.fetchPopularMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.fetchedMovies = movies
                self.fetchedPages += 1
                self.presenter.present(movies: self.movieGridUnits(from: movies))
            case .failure:
                self.presenter.presentNetworkError()
            }
        }
    }
    
    func toggleFavoriteMovie(at index: Int) {
        if let movie = self.fetchedMovies[safe: index] {
            do {
                try self.persistence.toggleFavorite(movie: movie)
                self.fetchMovieList(page: self.fetchedPages)
            } catch {
                self.presenter.presentFavoritesError()
            }
        } else {/*do nothing*/}
    }
    
    func filterMoviesBy(string: String) {
        guard !string.isEmpty else {
            self.presenter.present(movies: movieGridUnits(from: self.fetchedMovies))
            return
        }
        let candidates = self.fetchedMovies.filter { movie in movie.title.contains(string) }
        
        if candidates.isEmpty {
            self.presenter.presentNoResultsFound(for: string)
        } else {
            self.presenter.present(movies: movieGridUnits(from: candidates))
        }
    }
}
