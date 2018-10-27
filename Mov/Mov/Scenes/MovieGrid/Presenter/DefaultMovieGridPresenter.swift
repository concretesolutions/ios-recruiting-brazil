//
//  DefaultMovieGridPresenter.swift
//  ShitMov
//
//  Created by Miguel Nery on 23/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

final class DefaultMovieGridPresenter {
    
    private var viewOutput: MovieGridViewOutput
    
    init(viewOutput: MovieGridViewOutput) {
        self.viewOutput = viewOutput
    }
    
    /**
     Build MovieGridViewModels based on ```movies``` data. Each element in ```movies```will generate a correspondent MovieGridViewModel
     
     - Parameter movies: data to build MovieGridViewModels from
     */
    private func buildMovieGridViewModels(from movies: [MovieGridUnit]) -> [MovieGridViewModel] {
        return movies.map { movie in
            return MovieGridViewModel(title: movie.title, poster: kImages.poster_placeholder, isFavoriteIcon: kImages.isFavoriteIconEmpty)
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
