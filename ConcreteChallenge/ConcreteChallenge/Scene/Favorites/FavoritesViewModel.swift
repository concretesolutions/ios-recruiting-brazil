//
//  FavoritesViewModel.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

class FavoritesViewModel: ViewModel {
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

    func loadFavorites() {
        state = .loading

        do {
            let movies: [Movie] = try Movie.all()
            let results = movies.map({ MovieCellViewModel(movie: $0) })
            self.model = results
            self.updateData?(results)
            self.state = .show
        } catch {
            // TODO: send error to view
            debugPrint(error)
        }
    }
}
