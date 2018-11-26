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
    
    func viewDidLoad() { }
    
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
        }
        self.interactor.readFavoriteMovies()
        self.interactor.checkIfHasFilters()
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
        if movies.isEmpty {
            self.view?.presentEmptyView()
        } else {
            self.view?.present(movies: movies)
//            self.interactor.checkIfHasFilters()
        }
    }
    
    func didSearchMovies(withTitle title: String, _ movies: [Movie]) {
        if movies.isEmpty {
            self.view?.presentEmptyView()
        } else {
            self.view?.present(movies: movies)
        }
    }
    
    func didCheckIfHasFilters(_ has: Bool) {
        print("did check if has filters: \(has)")
        if has {
            self.view?.showRemoveFilterButton()
        } else {
            self.view?.hideRemoveFilterButton()
        }
    }
    
}
