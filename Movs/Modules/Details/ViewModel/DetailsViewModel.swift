//
//  DetailsViewModel.swift
//  Movs
//
//  Created by Joao Lucas on 14/10/20.
//

import Foundation
import RealmSwift

class DetailsViewModel: DataLifeViewModel {
    
    var useCase: MoviesListUseCase
    
    var successAdding = DataLife<String>()
    
    var successRemoving = DataLife<String>()
    
    init(useCase: MoviesListUseCase) {
        self.useCase = useCase
    }
    
    func loadAddToFavorite(realm: Realm, movie: ResultMoviesDTO) {
        useCase.addToFavorites(realm: realm, movie: movie) {
            self.successAdding.value = "Success in adding to favorites"
        }
    }
    
    func loadRemoveFavorite(realm: Realm, movie: ResultMoviesDTO) {
        useCase.removeFavorites(realm: realm, movie: movie) {
            self.successRemoving.value = "Success when removing from favorites"
        }
    }
    
}
