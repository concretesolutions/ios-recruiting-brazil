//
//  MovieListRouter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol MovieListRoutingLogic {
    func showMovieDetail()
}

protocol MovieListDataPassing {
    var dataStore: MovieListDataStore? { get }
}

class MovieListRouter: MovieListRoutingLogic, MovieListDataPassing {
    weak var viewController: MovieListViewController!
    var dataStore: MovieListDataStore?
    
    func showMovieDetail() {
        if let movie = dataStore?.movie {
            let movieDetailViewController = MovieDetailViewController(movie: movie)
            viewController.show(movieDetailViewController, sender: nil)
        }
    }
}
