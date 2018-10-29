//
//  MovieGridBuilder.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class MovieGridBuilder {
    
    static func build() -> MovieGridViewController {
        return viewOutput
    }
    
    static var viewOutput: MovieGridViewController {
        return MovieGridViewController()
    }
    
    static func presenter(viewOutput: MovieGridViewOutput) -> MovieGridPresenter {
        return DefaultMovieGridPresenter(viewOutput: viewOutput)
    }
    
    static func interactor(presenter: MovieGridPresenter) -> MovieGridInteractor {
        return DefaultMovieGridInteractor(presenter: presenter, movieFetcher: movieFetcher, moviePersistence: moviePersistence)
    }
    
    static private var movieFetcher: MovieFetcher {
        return TMDBMoyaGateway()
    }
    
    static private var moviePersistence: MoviePersistence {
        return HuePersistence()
    }
}
