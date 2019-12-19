//
//  MoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

typealias VoidClosure = () -> Void
typealias MovieClosure = (Movie) -> Void

class MoviesViewModel {
    enum State {
        case loading, empty, list, grid
    }

    var state: State = .empty {
        didSet {
            switch state {
            case .empty:
                setEmptyLayout?()
            case .loading:
                setLoadingLayout?()
            case .list:
                setListLayout?()
            case .grid:
                setGridLayout?()
            }
        }
    }

    var movies = [Movie]()

//    var networkManager: NetworkManager!

    // MARK: Coordinator actions

    var showMovieDetail: MovieClosure?

    // MARK: View actions

    var setLoadingLayout: VoidClosure?
    var setEmptyLayout: VoidClosure?
    var setListLayout: VoidClosure?
    var setGridLayout: VoidClosure?

    // TODO: mock NetworkManager
//    init(networkManager: NetworkManager = NetworkManager()) {
//        self.networkManager = networkManager
//    }

    func loadMovies() {
        state = .loading
    }
}
