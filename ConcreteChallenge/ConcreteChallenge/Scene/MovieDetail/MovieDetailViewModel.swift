//
//  MovieDetailViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

class MovieDetailViewModel {
    enum State {
        case loading, show
    }

    var state: State = .loading {
        didSet {
        switch state {
        case .loading:
            break
        case .show:
            break
        }
        }
    }

    var movie: Movie

    var networkManager: NetworkManager<MovieService>!

    // MARK: View actions

    var setLoadingLayout: VoidClosure?
    var setShowLayout: VoidClosure?

    // TODO: mock NetworkManager
    init(movie: Movie, networkManager: NetworkManager<MovieService> = NetworkManager()) {
        self.networkManager = networkManager
        self.movie = movie
    }
}
