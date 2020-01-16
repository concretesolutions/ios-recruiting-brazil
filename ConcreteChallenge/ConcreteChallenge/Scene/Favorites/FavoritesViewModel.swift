//
//  FavoritesViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

import Foundation

class FavoritesViewModel: ViewModel {
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
            updateData?(model)
        }
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

    func loadFavorites() {
        state = .loading

        do {
            let movies: [Movie] = try Movie.all()
            let results = movies.map({ MovieCellViewModel(movie: $0) })
            model = results
            state = .show
        } catch {
            state = .error(error)
        }
    }
}
