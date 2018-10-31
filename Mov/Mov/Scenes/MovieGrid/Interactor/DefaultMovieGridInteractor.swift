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
    
    private var fetchedMovies = [Movie]()

    private var fetchedPages = 0
    
    init(presenter: MovieGridPresenter, movieFetcher: MovieFetcher, persistence: FavoritesPersistence) {
        self.presenter = presenter
        self.movieFetcher = movieFetcher
        self.persistence = persistence
    }
    
    private func buildMovieGridUnits(from movies: [Movie]) -> [MovieGridUnit] {
        return movies.map { movie in
            let isFavorite = self.persistence.isFavorite(movie)
            return MovieGridUnit(id: movie.id, title: movie.title, posterPath: movie.posterPath, isFavorite: isFavorite)
        }
    }
}

extension DefaultMovieGridInteractor: MovieGridInteractor {
    
    func fetchMovieList(page: Int) {
        // no need to fetch again if requested page was already fetched
        guard page > fetchedPages else {
            self.presenter.present(movies: buildMovieGridUnits(from: self.fetchedMovies))
            return
        }

        self.movieFetcher.fetchPopularMovies(page: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let movies):
                self.fetchedMovies = movies
                self.fetchedPages += 1
                self.presenter.present(movies: self.buildMovieGridUnits(from: movies))
            case .failure:
                self.presenter.presentNetworkError()
            }
        }
    }
    
    func toggleFavoriteMovie(at index: Int) {
        print(index)
        if let movie = self.fetchedMovies[safe: index] {
            self.persistence.toggleFavorite(movie: movie)
            self.presenter.present(movies: buildMovieGridUnits(from: self.fetchedMovies))
        } else {/*do nothing*/}
    }
    
    func filterMoviesBy(string: String) {
        guard !string.isEmpty else {
            self.presenter.present(movies: buildMovieGridUnits(from: self.fetchedMovies))
            return
        }
        let candidates = self.fetchedMovies.filter { movie in
            movie.title.lowercased().range(of: string.lowercased()) != nil }
        if candidates.isEmpty {
            self.presenter.presentNoResultsFound(for: string)
        } else {
            self.presenter.present(movies: buildMovieGridUnits(from: candidates))
        }
    }
}
