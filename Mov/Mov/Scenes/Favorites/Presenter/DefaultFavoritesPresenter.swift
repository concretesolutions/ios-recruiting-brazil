//
//  DefaultFavoritesPresenter.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

final class DefaultFavoritesPresenter {
    
    private unowned let viewOutput: FavoritesViewOutput
    
    init(viewOutput: FavoritesViewOutput) {
        self.viewOutput = viewOutput
    }
    
    func favoritesViewModels(from units: [FavoritesUnit]) -> [FavoritesViewModel] {
        return units.map { unit in FavoritesViewModel(from: unit)}
    }
}


extension DefaultFavoritesPresenter: FavoritesPresenter {
    
    func present(movies: [FavoritesUnit]) {
        self.viewOutput.display(movies: favoritesViewModels(from: movies))
    }
    
    func presentNoResultsFound(for request: String) {
        self.viewOutput.displayNoResults(for: request)
    }
    
    func presentFetchError() {
        self.viewOutput.displayFetchError()
    }
    
    func presentFavoritesError() {
        self.viewOutput.displayFavoritesError()
    }
    
}
