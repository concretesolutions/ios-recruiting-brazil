//
//  MoviesCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
/**
 Coordinator Responsible for the Movies View
*/
class MoviesCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    init() {
        self.rootViewController = MovieViewController()
//        self.rootViewController.view.backgroundColor = .blue

    }
    
    func start() {
        
    }
    
    func showMovieDetail(movie: Movie) {
        
    }
}

extension MoviesCoordinator: MovieViewPresenterDelegate {
    func selectedMovie(movie: Movie) {
        showMovieDetail(movie: movie)
    }
}
