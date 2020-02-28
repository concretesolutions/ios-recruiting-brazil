//
//  FavoritesCoordinator.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 20/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
/**
 Coordinator Responsible for the Favorites View
*/
class FavoritesCoordinator: Coordinator {
    
    var rootViewController: UIViewController
    
    init() {
        let moviePresenter = FavoriteMoviePresenter()
        self.rootViewController = FavoriteViewController(presenter: moviePresenter)
        moviePresenter.movieView = self.rootViewController as! FavoriteViewController
        moviePresenter.delegate = self
    }
    
    func start() {
        
    }
    
    func showMovieDetail(movie: Movie) {
        let detailVC = createDetailVC(show: movie)
        guard let navigationController = rootViewController.navigationController else { fatalError() }
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func createDetailVC(show movie: Movie) -> MovieDetailViewController {
        let movieDetailPresenter = MovieDetailPresenter()
        let viewController = MovieDetailViewController(presenter: movieDetailPresenter,
                                                       movie: movie)
        movieDetailPresenter.movieView = viewController
        return viewController
    }
}

extension FavoritesCoordinator: MovieViewPresenterDelegate {
    func selectedMovie(movie: Movie) {
        showMovieDetail(movie: movie)
    }
}
