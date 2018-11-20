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
    
    // MARK: - MoviesPresentation protocol functions
    
    func viewDidLoad() { 
        self.interactor.readMoviesFor(page: 1)
    }
    
    func didSelect(movie: Movie) {
        self.router.presentMovieDetailsFor(movie)
    }
    
    func didTapFavoriteButtonTo(movie: Movie) {
        if movie.isFavorite {
            self.interactor.unfavorite(movie: movie)
        } else {
            self.interactor.favorite(movie: movie)
        }
    }
    
    func didSearchMoviesWith(name: String) {
        
    }
    
    // MARK: - MoviesInterectorOutput protocol functions
    
    func didReadMoviesForPage(_ page: Int, _ movies: [Movie]) {
        if page == 1 {
            self.view?.present(movies: movies)
        } else {
            
        }
    }
    
    func didFilterMoviesWithName(_ name: String, _ movies: [Movie]) {
        self.view?.present(movies: movies)
    }
    
    func didRemoveFilter(_ movies: [Movie]) {
        self.view?.present(movies: movies)
    }

}
