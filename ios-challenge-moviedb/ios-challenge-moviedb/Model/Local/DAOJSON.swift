//
//  DAOJSON.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 26/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

/**
 *Singleton* Responsible for all *JSON* related actions
 */
final class JSONDataAccess {
    
    // MARK: Singleton
    
    /**
     Base path of JSON Directory
     */
    private let jsonDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    /**
     Path of JSON Favorites
     */
    private var jsonPathFavorite: URL
    /**
     Path of JSON Genres
     */
    private var jsonPathGenre: URL
    /**
     Path of JSON Genres
     */
    private var jsonPathAllGenre: URL
    
    /// The single instance of `DataAccess`
    /**
     The single instance of `DataAccess`
     */
    static let object = JSONDataAccess()
    
    private init() {
        jsonPathFavorite = URL(fileURLWithPath: jsonDirectory.appending("/favorite.json"))
        jsonPathGenre = URL(fileURLWithPath: jsonDirectory.appending("/moviesgenre.json"))
        jsonPathAllGenre = URL(fileURLWithPath: jsonDirectory.appending("/allgenre.json"))
    }
    
    // MARK: - Methods
    
    /**
       Make an Movie into a Favorite Movie
       
       - Parameters:
       - movie: Movie to set as Favorite
       */
    func isFavorite(movie: Movie) {
        var favoriteGenres: [String] = []
        for genre in LocalData.object.getAllGenres() {
            for genreId in movie.genreIds {
                if genre.id == genreId {
                    favoriteGenres.append(genre.name)
                }
            }
        }
        let genreString = favoriteGenres.joined(separator: ", ")
        saveFavoriteMovieGenres(genres: [movie.id:genreString])
        saveFavorites(newFavorite: movie, type: .add)
    }
    
    /**
     Make an Movie into a not Favorite Movie
     
     - Parameters:
     - movie: Movie to set as not Favorite
     */
    func isNotFavorite(movie: Movie) {
        var favoriteMovies = LocalData.object.getAllFavoriteMovies()
        favoriteMovies.removeValue(forKey:movie.id)
        saveFavorites(newFavorite: movie, type: .remove)
    }
    
    /**
     Loads the SaveData saved in JSON
     */
    func loadSave() -> SaveData {
        var saveData: SaveData = SaveData(favoriteMovies: [:], favoriteGenres: [:], allGenres: [])
        do {
            let favoriteMoviesData = try Data(contentsOf: jsonPathFavorite)
            let favoriteMovies = try JSONDecoder().decode([Int:Movie].self, from: favoriteMoviesData)
            saveData.favoriteMovies = favoriteMovies
            
            let favoriteMovieGenresData = try Data(contentsOf: jsonPathGenre)
            let favoriteMovieGenres = try JSONDecoder().decode([Int:String].self, from: favoriteMovieGenresData)
            saveData.favoriteGenres = favoriteMovieGenres
            
            let allGenresData = try Data(contentsOf: jsonPathAllGenre)
            let allGenres = try JSONDecoder().decode([Genre].self, from: allGenresData)
            saveData.allGenres = allGenres
        } catch {
            print("Não foi possivel Carregar as informações")
        }
        
        return saveData
    }

    /**
     Saves the Favorites in JSON
     */
    private func saveFavorites(newFavorite: Movie, type: SaveType) {
        var favorites = LocalData.object.getAllFavoriteMovies()
        if type == .add {
            favorites[newFavorite.id] = newFavorite
        } else {
            favorites.removeValue(forKey:newFavorite.id)
        }
        do {
            try JSONEncoder().encode(favorites).write(to: self.jsonPathFavorite)
        } catch {
            print("não conseguiu salvar nos favoritor")
        }
        return
    }
    
    /**
     Saves the Favorites Genres in Json
     */
    private func saveFavoriteMovieGenres(genres: [Int:String]) {
        do {
            try JSONEncoder().encode(genres).write(to: self.jsonPathGenre)
        } catch {
            print("Não foi possivel salvar")
        }
        return
    }
    
    func saveAllGenres(genres: [Genre]) {
        do {
            try JSONEncoder().encode(genres).write(to: self.jsonPathAllGenre)
        } catch {
            print("Não foi possivel salvar localmente os saves")
        }
        return
    }
}

/**
Type of save action
 */
enum SaveType {
    case add
    case remove
}
