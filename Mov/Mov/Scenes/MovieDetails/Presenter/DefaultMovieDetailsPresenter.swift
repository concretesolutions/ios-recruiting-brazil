//
//  DefaultMovieDetailsPresenter.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation


class DefaultMovieDetailsPresenter {
    let viewOutput: MovieDetailsViewOutput
    
    init(viewOutput: MovieDetailsViewOutput) {
        self.viewOutput = viewOutput
    }
    
    func movieDetailsViewModel(for movie: MovieDetailsUnit) -> MovieDetailsViewModel {
        return MovieDetailsViewModel(from: movie)
    }
    
}

extension DefaultMovieDetailsPresenter: MovieDetailsPresenter {
    func presentDetails(of movie: MovieDetailsUnit) {
        self.viewOutput.displayDetails(of: movieDetailsViewModel(for: movie))
    }
    
    func presentFavoritesError() {
        self.viewOutput.displayFavoritesErorr()
    }
}
