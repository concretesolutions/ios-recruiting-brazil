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
        case loading, empty, show, error(Error)
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
            case .error(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.showError?(error)
                }
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
    var showError: ErrorClosure?

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
                    let results = movieResponse.results.map({ MovieCellViewModel(movie: $0) })
                    self?.model = results
                    self?.updateData?(results)
                    self?.state = .show
                }
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
}
