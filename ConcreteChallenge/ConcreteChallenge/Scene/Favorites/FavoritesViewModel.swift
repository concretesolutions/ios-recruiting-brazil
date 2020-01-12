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
            self.model = results
            self.updateData?(results)
            self.state = .show
        } catch {
            self.state = .error(error)
        }
    }
}
