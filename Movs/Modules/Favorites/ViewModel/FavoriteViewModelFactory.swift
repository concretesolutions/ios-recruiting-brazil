//
//  FavoriteViewModelFactory.swift
//  Movs
//
//  Created by Joao Lucas on 17/10/20.
//

import Foundation

class FavoriteViewModelFactory {
    
    func create() -> FavoritesViewModel {
        return FavoritesViewModel(useCase: FavoritesUseCase())
    }
}
