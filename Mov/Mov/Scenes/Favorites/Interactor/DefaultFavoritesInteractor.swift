//
//  DefaultFavoritesInteractor.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

final class DefaultFavoritesInteractor {
    let presenter: FavoritesPresenter
    let persistence: FavoritesPersistence
    let favorites = [Movie]()
    
    init(presenter: FavoritesPresenter, persistence: FavoritesPersistence) {
        self.presenter = presenter
        self.persistence = persistence
    }
    
    private func favoritesUnits(from movies: [Movie]) -> [FavoritesUnit] {
        return movies.map { movie in FavoritesUnit(from: movie) }
    }
}

extension DefaultFavoritesInteractor: FavoritesInteractor {
    
    func fetchFavorites() {
        guard self.favorites.isEmpty else {
            
            self.presenter.present(movies: favoritesUnits(from: self.favorites))
            return
        }
        
        if let favorites = self.persistence.fetchFavorites() {
            self.presenter.present(movies: favoritesUnits(from: favorites))
        } else {
            self.presenter.presentError()
        }
        
    }
    
    func toggleFavoriteMovie(at index: Int) {
        if let favorite = self.favorites[safe: index] {
            self.persistence.toggleFavorite(movie: favorite)
        } else {/*do nothing*/}
    }
    
    func filterMoviesBy(string: String) {
        guard !string.isEmpty else {
            self.presenter.present(movies: favoritesUnits(from: self.favorites))
            return
        }
        
        let candidates = self.favorites.filter { movie in movie.title.contains(string) }
        if candidates.isEmpty {
            self.presenter.presentNoResultsFound(for: string)
        } else {
            self.presenter.present(movies: favoritesUnits(from: candidates))
        }
    }
    
    
}
