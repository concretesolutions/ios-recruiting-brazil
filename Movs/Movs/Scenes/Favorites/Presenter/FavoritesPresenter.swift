//
//  FavoritesPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FavoritesPresenter: FavoritesPresentationLogic {
    weak var viewController: FavoritesDisplayLogic!
    
    func present(response: Favorites.Response) {
        let viewModel = Favorites.ViewModel(movies: response.movies)
        viewController.displayFavorites(viewModel: viewModel)
    }
}
