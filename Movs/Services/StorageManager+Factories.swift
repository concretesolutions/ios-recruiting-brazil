//
//  StorageManager+Factories.swift
//  Movs
//
//  Created by Gabriel D'Luca on 19/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import CoreData

extension StorageManager: CoreDataFactory {
    func createFavoriteMovie(movie: Movie, description: NSEntityDescription) -> CDFavoriteMovie {
        let instance = CDFavoriteMovie(entity: description, insertInto: self.managedContext)
        instance.backdropPath = movie.backdropPath
        instance.id = Int64(movie.id)
        instance.posterPath = movie.posterPath
        instance.releaseDate = movie.releaseDate
        instance.summary = movie.summary
        instance.title = movie.title
        
        do {
            let genreEntity = try self.createEntity(named: "CDGenre")
            let createdGenres = NSSet(array: movie.genres.map({
                self.createGenre(genre: $0, description: genreEntity)
            }))
            instance.addToGenres(createdGenres)
        } catch {
            fatalError()
        }
        
        return instance
    }
    
    func createGenre(genre: Genre, description: NSEntityDescription) -> CDGenre {
        let instance = CDGenre(entity: description, insertInto: self.managedContext)
        instance.id = Int64(genre.id)
        instance.name = genre.name
        return instance
    }
}
