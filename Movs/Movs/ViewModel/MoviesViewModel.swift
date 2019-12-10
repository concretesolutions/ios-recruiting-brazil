//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine

class MoviesViewModel {

    @Published var count = 0

//    private var movies = CurrentValueSubject<[Movie], Never>([])

    private lazy var popularMovies = CurrentValueSubject<[Movie], Never>([])
    private lazy var searchMovies = CurrentValueSubject<[Movie], Never>([])

    private var currentPopularMoviesPage: Int = 1
    private var currentSearchMoviesPage: Int = 1

    var popularMoviesCancellable: AnyCancellable?

    init() {
        let cancellable = MovieDatabaseService.popularMovies(fromPage: self.currentPopularMoviesPage)
            .assertNoFailure("Não temos internet")
            .sink { (movies) in
                self.popularMovies.send(movies)
                self.count = movies.count
            }
        self.popularMoviesCancellable = cancellable
    }

    public func getPopularMovies() {
        self.currentPopularMoviesPage += 1
        let cancellable = MovieDatabaseService.popularMovies(fromPage: self.currentPopularMoviesPage)
            .assertNoFailure("Não temos internet")
            .sink { (movies) in
                var totalMovies = self.popularMovies.value
                totalMovies.append(contentsOf: movies)
                self.popularMovies.send(totalMovies)
                self.count = totalMovies.count
            }
        self.popularMoviesCancellable = cancellable
    }

    public func getSearchMovies(withQuery query: String) {
        self.currentSearchMoviesPage += 1
        let cancellable = MovieDatabaseService.searchMovies(withQuery: query, fromPage: self.currentSearchMoviesPage)
            .assertNoFailure("Não temos internet")
            .sink { (movies) in
                self.searchMovies.send(movies)
                self.count = movies.count
            }
        self.popularMoviesCancellable = cancellable
    }

    func viewModel(forCellAt indexPath: IndexPath) -> MovieViewModel {
        let viewModel = MovieViewModel(withMovie: self.popularMovies.value[indexPath.row])
        return viewModel
    }

}
