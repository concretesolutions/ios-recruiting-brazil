//
//  BookMarkListPresenter.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListPresenter: ViewToFavoritesListPresenterProtocol {
    var view: PresenterToFavoritesListViewProtocol?
    
    var iteractor: PresenterToFavoritesListIteractorProtocol?
    
    var route: PresenterToFavoritesListRouterProtocol?
    
    func loadFavorites() {
        self.iteractor?.loadFavorites()
    }
    
    func remove(favorite: FavoritesDetailsData) {
        self.iteractor?.remove(favorite: favorite)
    }
}

extension FavoritesListPresenter : IteractorToFavoritesListPresenterProtocol {
    func returnFavorites(favorites: [FavoritesDetailsData]) {
        self.view?.returnFavorites(favorites: favorites)
    }
    
    func returnFavoritesError(message: String) {
        self.view?.returnFavoritesError(message: message)
    }
    
    func returnRemoveFavorites() {
        self.view?.returnRemoveFavorites()
    }
    
    func returnRemoveFavoritesError(message: String) {
        self.view?.returnFavoritesError(message: message)
    }
}
