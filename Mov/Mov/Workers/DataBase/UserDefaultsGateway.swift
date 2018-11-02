//
//  FavoriteMoviesUserDefaultsPersistence.swift
//  Mov
//
//  Created by Miguel Nery on 29/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class UserDefaultsGateway {
    private static let moviesKey = "Movies"
    
    let defaults = UserDefaults.standard
}

extension UserDefaultsGateway: FavoritesPersistence {
    
    func toggleFavorite(movie: Movie) throws {
        var favorites = try self.fetchFavorites()
        if favorites.contains(movie) {
            favorites.remove(movie)
        } else {
            favorites.insert(movie)
        }
        
        try self.save(favorites: favorites)
    }
    
    func fetchFavorites() throws -> Set<Movie> {
        if let savedMovies = self.defaults.object(forKey: UserDefaultsGateway.moviesKey) as? Data {
            let decoder = API.TMDB.decoder
            let loadedMovies = try decoder.decode([Movie].self, from: savedMovies)
            return Set<Movie>(loadedMovies)
        } else { return [] }
    }
    
    func save(favorites: Set<Movie>) throws {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .formatted(API.TMDB.dateFormatter)
        
        let encoded = try encoder.encode(favorites)
        self.defaults.set(encoded, forKey: UserDefaultsGateway.moviesKey)
    }
}
