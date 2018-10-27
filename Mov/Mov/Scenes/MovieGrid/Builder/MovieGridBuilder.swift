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
        let viewOutput = MovieGridViewController()
        let interactor = DefaultMovieGridInteractor(movieFetcher: movieFetcher, moviePersistence: moviePersistence)
        let presenter = DefaultMovieGridPresenter()
        
        viewOutput.interactor = interactor
        interactor.presenter = presenter
        presenter.viewOutput = viewOutput
        
        return viewOutput
    }
    
    static private var movieFetcher: MovieFetcher {
        return TMDBMoyaGateway()
    }
    
    static private var moviePersistence: MoviePersistence {
        return HuePersistence()
    }
    
}
