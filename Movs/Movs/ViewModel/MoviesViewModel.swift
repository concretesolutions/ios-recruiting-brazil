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

    public let movies = CurrentValueSubject<[Movie], MovieDatabaseServiceError>([])

    private var currentPopularMoviesPage: Int = 1

    var popularMoviesCancellable: AnyCancellable?

    init() {
        self.getMovies()
    }

    public func getMovies() {
        let cancellable = MovieDatabaseService.popularMovies(fromPage: self.currentPopularMoviesPage)
            .assertNoFailure("Deu ruim pegando filmes populares")
            .sink { (movies) in
                var totalMovies = self.movies.value
                totalMovies.append(contentsOf: movies)
                self.movies.send(totalMovies)
                self.count = totalMovies.count
                self.currentPopularMoviesPage += 1
        }
        self.popularMoviesCancellable = cancellable
    }

    func viewModel(forCellAt indexPath: IndexPath) -> MoviesCollectionCellViewModel {
        let viewModel = MoviesCollectionCellViewModel(withMovie: self.movies.value[indexPath.row])
        return viewModel
    }

}
