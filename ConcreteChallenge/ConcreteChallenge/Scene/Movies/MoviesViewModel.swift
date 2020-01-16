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
            DispatchQueue.main.async { [weak self] in
                switch self?.state {
                case .empty: self?.setEmptyLayout?()
                case .loading: self?.setLoadingLayout?()
                case .show: self?.setShowLayout?()
                case .error(let error): self?.showError?(error)
                default: break
                }
            }
        }
    }

    var model = [MovieCellViewModel]() {
        didSet {
            // Update view only with the new data
            let newViewModels: [MovieCellViewModel] = model.suffix(model.count - oldValue.count)
            DispatchQueue.main.async { [weak self] in
                self?.updateData?(newViewModels)
            }
        }
    }

    var networkManager: AnyNetworkManager

    var currentPage = 1

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
        networkManager.cancel()

        networkManager.request(MovieService.popularMovies(page: currentPage)
        ) { [weak self] (result: Result<MovieResponse, Error>) in
            switch result {
            case .success(let movieResponse):
                self?.currentPage += 1
                self?.model.append(contentsOf: movieResponse.results.map({ MovieCellViewModel(movie: $0) }))
                self?.state = .show
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
}
