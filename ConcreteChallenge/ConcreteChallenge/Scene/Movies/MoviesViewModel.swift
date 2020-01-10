//
//  MoviesViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 18/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import NetworkLayer

class MoviesViewModel: ViewModel {
    enum State {
        case loading, empty, show
    }

    var state: State = .empty {
        didSet {
            switch self.state {
            case .empty:
                self.setEmptyLayout?()
            case .loading:
                self.setLoadingLayout?()
            case .show:
                self.setShowLayout?()
            }
        }
    }

    var model = [MovieCellViewModel]()

    var networkManager: AnyNetworkManager

    init(networkManager: AnyNetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }

    // MARK: Coordinator actions

    var showMovieDetail: MovieClosure?

    // MARK: View updates

    var setLoadingLayout: VoidClosure?
    var setEmptyLayout: VoidClosure?
    var setShowLayout: VoidClosure?

    var updateData: MovieCellViewModelClosure?

    // MARK: User actions

    func didSelectMovie(index: Int) {
        showMovieDetail?(model[index].model)
    }

    func loadMovies() {
        state = .loading

        networkManager.request(MovieService.popularMovies) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                DispatchQueue.main.async { [weak self] in
                    let results = movieResponse.results.map({ MovieCellViewModel(model: $0) })
                    self?.model = results
                    self?.updateData?(results)
                    self?.state = .show
                }
            case .failure(let error):
                // TODO: send error to view
                debugPrint(error)
            }
        }
    }
}
