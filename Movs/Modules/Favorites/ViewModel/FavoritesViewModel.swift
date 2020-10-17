//
//  FavoritesViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 17/10/20.
//

import Foundation
import RealmSwift

class FavoritesViewModel: DataLifeViewModel {
    
    var useCase: FavoritesUseCase!
    
    var successRemove = DataLife<Int>()
    
    init(useCase: FavoritesUseCase) {
        self.useCase = useCase
    }
    
    func fetchRemove(realm: Realm, item: FavoriteEntity, index: IndexPath) {
        useCase.removeFavoriteList(realm: realm, item: item) {
            self.successRemove.value = index.row
        }
    }
}
