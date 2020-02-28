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
        jsonPathFavorite = URL(fileURLWithPath: jsonDirectory.appending("/favorite.json"))
        jsonPathGenre = URL(fileURLWithPath: jsonDirectory.appending("/genre.json"))
    }
    
    // MARK: - Methods
    
    func isFavorite(movie: Movie) {
        var favoriteGenres: [String] = []
        for genre in LocalData.object.getAllGenres() {
            for genreId in movie.genreIds {
                if genre.key == genreId {
                    favoriteGenres.append(genre.value)
                }
            }
        }
        let genreString = favoriteGenres.joined(separator: ", ")
        saveFavoriteMovieGenres(genres: [movie.id:genreString])
        saveFavorites(newFavorite: movie, type: .add)
    }
    
    func isNotFavorite(movie: Movie) {
        var favoriteMovies = LocalData.object.getAllFavoriteMovies()
        favoriteMovies.removeValue(forKey:movie.id)
        saveFavorites(newFavorite: movie, type: .remove)
    }
    
    ///Loads the SaveData saved in Json
    func loadSave() -> SaveData {
        var saveData: SaveData = SaveData(favoriteMovies: [:], favoriteGenres: [:])
        do {
            let favoriteMoviesData = try Data(contentsOf: jsonPathFavorite)
            let favoriteMovies = try JSONDecoder().decode([Int:Movie].self, from: favoriteMoviesData)
            saveData.favoriteMovies = favoriteMovies
            
            let favoriteMovieGenresData = try Data(contentsOf: jsonPathGenre)
            
            let favoriteMovieGenres = try JSONDecoder().decode([Int:String].self, from: favoriteMovieGenresData)
            saveData.favoriteGenres = favoriteMovieGenres
        } catch { }
        return saveData
    }
    
    ///Saves the SaveData in Json
    private func saveFavorites(newFavorite: Movie, type: SaveType) {
        var favorites = LocalData.object.getAllFavoriteMovies()
        if type == .add {
            favorites[newFavorite.id] = newFavorite
        } else {
            favorites.removeValue(forKey:newFavorite.id)
        }
        print("saveFavorites: ", favorites.count)
        do {
            try JSONEncoder().encode(favorites).write(to: self.jsonPathFavorite)
        } catch {
            print("não conseguiu salvar nos favoritor")
        }
        return
    }
    
    private func saveFavoriteMovieGenres(genres: [Int:String]) {
        do {
            try JSONEncoder().encode(genres).write(to: self.jsonPathFavorite)
        } catch {
            // Tratar o erro
            print("Não foi possivel salvar")

        }
        return
    }
}

enum SaveType {
    case add
    case remove
}
