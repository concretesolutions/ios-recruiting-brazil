//
//  StorageManager+CRUD.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import CoreData
import UIKit

// MARK: - Create

extension StorageManager {
    func storeGenre(genre: Genre) {
        guard !self.isGenreStored(genreID: genre.id) else {
            return
        }
        
        do {
            let entity = try self.createEntity(named: "CDGenre")
            let storedGenre = self.createGenre(genre: genre, description: entity)
            self.genres.insert(storedGenre)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func storeFavorite(movie: Movie) {
        guard !self.isMovieStored(movieID: movie.id) else {
            return
        }
        
        do {
            let entity = try self.createEntity(named: "CDFavoriteMovie")
            let favoriteMovie = self.createFavoriteMovie(movie: movie, description: entity)
            self.favorites.insert(favoriteMovie)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
    
// MARK: - Read

extension StorageManager {
    func isGenreStored(genreID: Int) -> Bool {
        return self.genres.map({ $0.id }).contains(Int64(genreID))
    }

    func isMovieStored(movieID: Int) -> Bool {
        return self.favorites.map({ $0.id }).contains(Int64(movieID))
    }
    
    func getFavoriteMovie(movieID: Int) -> CDFavoriteMovie {
        let results = self.favorites.filter({ $0.id == Int64(movieID) })

        guard let movie = results.first else { fatalError() }
        return movie
    }
    
    func getGenre(genreID: Int) -> CDGenre {
        let results = self.genres.filter({ $0.id == Int64(genreID) })
        
        guard let genre = results.first else { fatalError() }
        return genre
    }
}

// MARK: - Update

extension StorageManager {
    func updateFavoriteMovie(with movie: MovieDTO) throws {
        let storedMovie = self.getFavoriteMovie(movieID: movie.id)
        storedMovie.backdropPath = movie.backdropPath
        storedMovie.summary = movie.overview
        storedMovie.title = movie.title
        storedMovie.posterPath = movie.posterPath
        
        if let genreIDs = movie.genreIDS {
            storedMovie.genres = NSSet(array: genreIDs.map({ id in
                self.getGenre(genreID: id)
            }))
        }
        
        if let movieRelease = movie.releaseDate {
            storedMovie.releaseDate = try Date(string: movieRelease)
        }
    }
}

// MARK: - Delete

extension StorageManager {
    func deleteGenresIfNeeded(fetchedGenres: [GenreDTO]) {
        let fetchedIDs = fetchedGenres.map { $0.id }
        let removedGenres = self.genres.filter({ storedGenre in
            let storedID = Int(storedGenre.id)
            return fetchedIDs.contains(storedID)
        })
        
        for genre in removedGenres {
            self.genres.remove(genre)
        }
    }
    
    func deleteFavorite(movieID: Int) {
        let objects = self.favorites.filter({ $0.id == Int64(movieID) })
        for object in objects {
            self.managedContext.delete(object)
            self.favorites.remove(object)
        }
    }
}
