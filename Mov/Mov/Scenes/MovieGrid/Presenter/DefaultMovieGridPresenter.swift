//
//  DefaultMovieGridPresenter.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

final class DefaultMovieGridPresenter {
    
    var viewOutput: MovieGridViewOutput!
    
    private func buildMovieGridViewModels(from movies: [MovieGridUnit]) -> [MovieGridViewModel] {
        return movies.map { movie in
            return MovieGridViewModel(
                title: movie.title,
                posterPath: movie.posterPath,
                isFavoriteIcon: movie.isFavorite ? Images.isFavoriteIconFull : Images.isFavoriteIconGray)
        }
    }
}

extension DefaultMovieGridPresenter: MovieGridPresenter {
    
    func present(movies: [MovieGridUnit]) {
        self.viewOutput.display(movies: buildMovieGridViewModels(from: movies))
    }
    
    func presentNetworkError() {
        self.viewOutput.displayNetworkError()
    }
    
}
