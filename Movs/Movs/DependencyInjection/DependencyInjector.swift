//
//  DependencyInjector.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

class DependencyInjector {

    static func registerDependencies() {
        let container = DependencyResolver.shared.container
        // Configuration

        container.register(MoviesViewModelable.self) { _ in
            MoviesViewModel()
        }

        container.register(FavoriteMoviesViewModelable.self) { _ in
            FavoriteMoviesViewModel()
        }

        container.register(MovieDetailTableViewModelable.self) { _, movie in
            MovieDetailTableViewModel(movie: movie)
        }

        container.register(MovieService.self) { _ in
            MovieHttpNetworkClient()
        }
    }
}
