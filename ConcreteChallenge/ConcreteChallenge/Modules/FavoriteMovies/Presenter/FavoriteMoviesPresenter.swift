//
//  FavoriteMoviesPresenter.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class FavoriteMoviesPresenter: FavoriteMoviesPresentation, FavoriteMoviesInteractorOutput {
    
    // MARK: - Properties
    var view: FavoriteMoviesView?
    var interactor: FavoriteMoviesInteractorInput!
    var router: FavoriteMoviesWireframe!
    
    // MARK: - FavoriteMoviesPresentation functions
    func viewDidLoad() {
    }
    
    func didRequestFavoriteMovies() {
        self.interactor.getFavoriteMovies()
    }
    
    func didTapFilterButton() {
        self.router.showFilterScreen()
    }
    
    func didSetFilters() {
        self.interactor.getFavoriteMovies()
    }

    func didAskForRemoveFilterButton() {
        self.interactor.askForRemoveFilterButton()
    }
    
    func didTapRemoveFiltersButton() {
        self.interactor.removeFilters()
        self.didAskForRemoveFilterButton()
    }
    
    // MARK: - FavoriteMoviesInteractorOutput functions
    func didGetFavoriteMovies(favoriteMovies: [Movie]) {
        if favoriteMovies.isEmpty {
            self.view?.showEmptyAlert()
        } else {
            self.view?.show(favoriteMovies: favoriteMovies)
        }
    }
    
    func didRemoveFavoriteMovie(at indexPath: IndexPath) {
        self.interactor.removeFavoriteMovie(at: indexPath)
    }
    
    func didAskForRemoveFilterButton(to activate: Bool) {
        self.view?.setRemoveButton(to: activate)
    }
}
