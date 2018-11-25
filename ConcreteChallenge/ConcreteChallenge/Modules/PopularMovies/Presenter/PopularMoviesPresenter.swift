//
//  PopularMoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class PopularMoviesPresenter: PopularMoviesPresentation, PopularMoviesInteractorOutput {
    
    // MARK: - Properties
    var view: PopularMoviesView?
    var interactor: PopularMoviesInteractorInput!
    var router: PopularMoviesWireframe!
    
    // MARK: - PopularMoviesPresentation functions
    func viewDidLoad() {
        self.view?.setActivityIndicator(to: true)
    }
    
    func didRequestMovies() {
        self.interactor.fetchMovies()
    }
    
    func didTapMovieCell(of movie: Movie) {
        self.router.showMovieDetail(for: movie)
    }
    
    // MARK: - PopularMoviesInteractorOutput functions
    func didFetch(movies: [Movie]) {
        self.view?.show(movies: movies)
        self.view?.setActivityIndicator(to: false)
    }
    
    func didFailedToFetchMovies() {
        self.view?.setActivityIndicator(to: false)
        self.view?.showErrorMessage()
    }
    
    func didChangeSearchBar(with text: String) {
        self.interactor.searchMovies(with: text)
    }
    
    func didSearchMovies(filteredMovies: [Movie]) {
        self.view?.show(movies: filteredMovies)
    }
}
