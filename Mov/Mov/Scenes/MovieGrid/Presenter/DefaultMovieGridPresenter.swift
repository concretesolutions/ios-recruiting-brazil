//
//  DefaultMovieGridPresenter.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

final class DefaultMovieGridPresenter {
    
    unowned let viewOutput: MovieGridViewOutput
    
    init(viewOutput: MovieGridViewOutput) {
        self.viewOutput = viewOutput
    }
    
    private func movieGridViewModels(from movies: [MovieGridUnit]) -> [MovieGridViewModel] {
        return movies.map { movie in MovieGridViewModel(from: movie,
                                                        isFavoriteIcon: movie.isFavorite ? Images.isFavoriteIconFull : Images.isFavoriteIconGray)
        }
    }
}

extension DefaultMovieGridPresenter: MovieGridPresenter {
    func present(movies: [MovieGridUnit]) {
        self.viewOutput.display(movies: movieGridViewModels(from: movies))
    }
    
    func presentNetworkError() {
        self.viewOutput.displayNetworkError()
    }
    
    func presentNoResultsFound(for request: String) {
        self.viewOutput.displayNoResults(for: request)
    }
}
