//
//  FavoritesListIteractor.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class FavoritesListIteractor: PresenterToFavoritesListIteractorProtocol {
    var presenter: IteractorToFavoritesListPresenterProtocol?
    let repository:FavoritesRepository = FavoritesRepository()
    func loadFavorites() {
        let favorites:[FavoritesDetailsData] = repository.loadFavorites()
        self.presenter?.returnFavorites(favorites: favorites)
    }
}
