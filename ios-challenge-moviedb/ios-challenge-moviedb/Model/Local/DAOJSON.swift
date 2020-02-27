//
//  DAOJSON.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 26/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

final class JSONDataAccess {
    
    // MARK: Singleton
    
    private let jsonDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    private var jsonPathFavorite: URL
    private var jsonPathGenre: URL

    
    /// The single instance of `DataAccess`
    static let object = JSONDataAccess()
    private init() {
        jsonPathFavorite = URL(fileURLWithPath: jsonDirectory.appending("favorite.json"))
        jsonPathGenre = URL(fileURLWithPath: jsonDirectory.appending("genre.json"))
    }
    
    // MARK: - Methods
    
    func isFavorite(movie: Movie) {
        saveFavorites(favorites: [movie.id:movie])
        
        var favoriteGenres: [String] = []
        
        for genre in LocalData.object.getAllGenres() {
            for genreId in movie.genreIds {
                if genre.key == genreId {
                    favoriteGenres.append(genre.value)
                }
            }
        }
        let genreString = favoriteGenres.joined(separator: ", ")
        saveFavoriteMovieGenres(genres: [movie.id: genreString])    }
    
    func isNotFavorite(movie: Movie) {
        var favoriteMovies = LocalData.object.getAllFavoriteMovies()
        favoriteMovies.removeValue(forKey: movie.id)
    }
    
    ///Loads the SaveData saved in Json
    func loadSave() -> SaveData {
        var saveData: SaveData = SaveData(favoriteMovies: [:], favoriteGenres: [:])
        do {
            let favoriteMoviesData = try Data(contentsOf: jsonPathFavorite)
            let favoriteMovies = try JSONDecoder().decode([Int:Movie].self, from: favoriteMoviesData)
            
            let favoriteMovieGenresData = try Data(contentsOf: jsonPathGenre)
            let favoriteMovieGenres = try JSONDecoder().decode([Int:String].self, from: favoriteMovieGenresData)
            
            saveData.favoriteMovies = favoriteMovies
            saveData.favoriteGenres = favoriteMovieGenres
        } catch {
            // Tratar o erro
        }
        return saveData
    }
    
    ///Saves the SaveData in Json
    private func saveFavorites(favorites: [Int:Movie]) {
        do {
            try JSONEncoder().encode(favorites).write(to: self.jsonPathFavorite)
        } catch {
            // Tratar o erro
        }
        return
    }
    
    private func saveFavoriteMovieGenres(genres: [Int:String]) {
        do {
            try JSONEncoder().encode(genres).write(to: self.jsonPathFavorite)
        } catch {
            // Tratar o erro
        }
        return
    }
}
