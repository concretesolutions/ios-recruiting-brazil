//
//  FavoritesPresenter.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class FavoritesPresenter: FavoritesPresentation, FavoritesInteractorOutput {
    
    // MARK: - Properties
    
    weak var view: FavoritesView?
    var router: FavoritesWireframe!
    var interactor: FavoritesUseCase!
    
    private var selectedMovie: Movie?
    private var selectedMovieIndex: Int?
    private var selectedMovieFavoriteState: Bool?
    
    
    // MARK: - FavoritesPresentation protocol functions
    
    func viewDidLoad() {
        self.interactor.readFavoriteMovies()
    }
    
    func viewDidAppear() {
        if let sm = self.selectedMovie,
           let smi = self.selectedMovieIndex,
           let smfs = self.selectedMovieFavoriteState {
            if smfs != sm.isFavorite {
                self.view?.delete(movieAt: smi)
            }
            self.selectedMovie = nil
            self.selectedMovieIndex = nil
            self.selectedMovieFavoriteState = nil
        } else {
            self.interactor.readFavoriteMovies()
        }
    }
    
    func didSelect(movie: Movie, index: Int) {
        self.selectedMovie = movie
        self.selectedMovieIndex = index
        self.selectedMovieFavoriteState = movie.isFavorite
        self.router.presentMovieDetailsFor(movie)
    }
    
    func didUnfavorite(movie: Movie) {
        self.interactor.unfavorite(movie: movie)
    }
    
    func didTapRemoveFilterButton() {
        self.view?.hideRemoveFilterButton()
        self.interactor.removeFilters()
        self.interactor.readFavoriteMovies()
    }
    
    func didSearchMovies(withTitle title: String) {
        self.interactor.searchMovies(withTitle: title)
    }
    
    func didFinishSearch() {
        self.interactor.readFavoriteMovies()
    }
    
    func didTapFilterButton() {
        self.router.presentFiltersView()
    }
    
    // MARK: - FavoritesInteractorOutput protocol functions
    
    func didRead(movies: [Movie]) {
        self.view?.present(movies: movies)
    }
    
    func didSearchMovies(withTitle title: String, _ movies: [Movie]) {
        self.view?.present(movies: movies)
    }
    
}
