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
    private(set) var favorites = [Movie]()
    
    init(presenter: FavoritesPresenter, persistence: FavoritesPersistence) {
        self.presenter = presenter
        self.persistence = persistence
    }
    
    private func favoritesUnits(from movies: [Movie]) -> [FavoritesUnit] {
        return movies.map { movie in FavoritesUnit(from: movie) }
    }
}

extension DefaultFavoritesInteractor: FavoritesInteractor {
    func movie(at index: Int) -> Movie? {
        return self.favorites[safe: index]
    }
    
    
    func fetchFavorites() {
        do {
            let favoritesSet = try self.persistence.fetchFavorites()
            self.favorites = Array(favoritesSet)
            self.presenter.present(movies: favoritesUnits(from: self.favorites))
        } catch {
            self.presenter.presentError()
        }
    }
    
    func toggleFavoriteMovie(at index: Int) {
        if let favorite = self.favorites[safe: index] {
            do {
                try self.persistence.toggleFavorite(movie: favorite)
                self.fetchFavorites()
            } catch {/*present db error*/}
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
