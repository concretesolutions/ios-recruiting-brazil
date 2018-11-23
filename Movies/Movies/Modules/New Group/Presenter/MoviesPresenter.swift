//
//  MoviesPresenter.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesPresenter: MoviesPresentation, MoviesInteractorOutput {
    
    // MARK: - Properties
    
    weak var view: MoviesView?
    var router: MoviesWireframe!
    var interactor: MoviesUseCase!
    private var lastMoviesPage: Int = 1
    
    // MARK: - MoviesPresentation protocol functions
    
    func viewDidLoad() { 
        self.interactor.getMovies(fromPage: 1)
    }
    
    func didSelect(movie: Movie) {
        self.router.presentMovieDetailsFor(movie)
    }
    
    func didTapFavoriteButton(forMovie movie: Movie) {
        if movie.isFavorite {
            self.interactor.unfavorite(movie: movie)
        } else {
            self.interactor.favorite(movie: movie)
        }
    }
    
    func didSearchMovies(withTitle title: String) {
        
    }
    
    func didFinishSearch() {
        self.interactor.getCurrentMovies()
    }
    
    // MARK: - MoviesInterectorOutput protocol functions
    func didGetMovies(fromPage page: Int, _ movies: [Movie]) {
        if page == 1 {
            self.view?.present(movies: movies)
        } else {
            self.lastMoviesPage = page
            self.view?.presentNew(movies: movies)
        }
    }
    
    func didGetCurrentMovies(_ movies: [Movie]) {
        self.view?.present(movies: movies)
    }
    
    func didSearchMovies(withTitle title: String, _ movies: [Movie]) {
        self.view?.present(movies: movies)
    }

}
