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
    
}

extension DefaultMovieGridPresenter: MovieGridPresenter {
    
    func present(movies: [Movie]) {
        self.viewOutput.display(movies: movies)
    }
    
    func presentNetworkError() {
        self.viewOutput.displayNetworkError()
    }
    
}
