//
//  FavoriteMoviesViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine

class FavoriteMoviesViewModel {

    @Published var count = 0

    private var movies: [Movie] = [] {
        didSet {
            self.count = self.movies.count
        }
    }

    var cancellabels: [AnyCancellable] = []
    var publisherCancellable: AnyCancellable?

    init() {
        self.getMovies()
        self.publisherCancellable = PersistenceService.publisher.sink { (_) in
            self.getMovies()
        }
    }

    private func getMovies() {
        self.movies = []
        let ids = PersistenceService.favoriteMovies
        for id in ids {
            let cancellable = MovsServiceAPI.getMovie(withId: id)
                .sink(receiveCompletion: { (completion) in

                }) { (movie) in
                    self.movies.append(movie)
            }
            self.cancellabels.append(cancellable)
        }
    }

    func viewModel(forCellAt indexPath: IndexPath) -> FavoriteMoviesCellViewModel {
        let viewModel = FavoriteMoviesCellViewModel(withMovie: self.movies[indexPath.row])
        return viewModel
    }

}
