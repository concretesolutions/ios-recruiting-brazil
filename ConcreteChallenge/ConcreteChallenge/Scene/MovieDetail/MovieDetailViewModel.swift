//
//  MovieDetailViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

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

    // MARK: View actions

    var setLoadingLayout: VoidClosure?
    var setShowLayout: VoidClosure?

    init(movie: Movie) {
        self.movie = movie
    }
}
