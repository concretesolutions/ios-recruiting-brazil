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
    
    // MARK: - FavoritesPresentation protocol functions
    
    func viewDidLoad() {
        self.interactor.readFavoriteMovies()
    }
    
    func didSelect(movie: Movie) {
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
    
    
}
