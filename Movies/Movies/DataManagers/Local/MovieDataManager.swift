//
//  MovieDataManager.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit
import CoreData

class MovieDataManager {
    
    // MARK: - Properties
    
    static var genresFilter: [Genre]  = []
    static var yearsFilter: [Int] = []
    
    // MARK: - Aux functions
    
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Movies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private static let context = persistentContainer.viewContext
    
    private static func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("error while saving context: \(error)")
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Favorite Movies
    
    private struct MovieModel {
        static let entityName = "MovieModel"
        static let id = "id"
        static let overview = "overview"
        static let posterPath = "poster_path"
        static let title = "title"
        static let year = "year"
        static let genres = "genres"
    }
    
    static func managedObject(_ movie: Movie) -> NSManagedObject? {
        if let entity = NSEntityDescription.entity(forEntityName: MovieModel.entityName, in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            object.setValue(movie.id, forKey: MovieModel.id)
            object.setValue(movie.overview, forKey: MovieModel.overview)
            object.setValue(movie.posterPath, forKey: MovieModel.posterPath)
            object.setValue(movie.title, forKey: MovieModel.title)
            object.setValue(movie.year, forKey: MovieModel.year)
            GenreDataManager.updateGenres(movie.genres)
            var genresMOs: [NSManagedObject] = []
            movie.genres.forEach {
                if let mo = GenreDataManager.genresMOs[$0.id] {
                    genresMOs.append(mo)
                } else if let mo = GenreDataManager.readGenreByIdReturninMO($0.id) {
                    saveContext()
                    genresMOs.append(mo)
                }
            }
            object.mutableOrderedSetValue(forKey: MovieModel.genres).addObjects(from: genresMOs)
            saveContext()
            return object
        }
        return nil
    }
    
    static func movie(_ mo: NSManagedObject) -> Movie? {
        if let id = mo.value(forKey: MovieModel.id) as? Int,
            let overview = mo.value(forKey: MovieModel.overview) as? String,
            let posterPath = mo.value(forKey: MovieModel.posterPath) as? String,
            let title = mo.value(forKey: MovieModel.title) as? String,
            let year = mo.value(forKey: MovieModel.year) as? Int {
            let movie = Movie(id: id, title: title, posterPath: posterPath, year: year, genres: [], overview: overview)
            mo.mutableOrderedSetValue(forKey: MovieModel.genres).forEach { item in
                if let genreObject = item as? NSManagedObject,
                    let genre = GenreDataManager.genre(genreObject) {
                    movie.genres.append(genre)
                }
            }
            return movie
        }
        return nil
    }
    
    static func createFavoriteMovie(_ movie: Movie) {
        let _ = managedObject(movie)
        movie.isFavorite = true
    }
    
    static func readFavoriteMovies() -> [Movie] {
        var movies: [Movie] = []
        let moviesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MovieModel.entityName)
        moviesRequest.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(moviesRequest)
            if let mos = result as? [NSManagedObject] {
                for mo in mos {
                    if let movie = movie(mo) {
                        movie.isFavorite = true
                        movies.append(movie)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return movies
    }
    
    static func readFavoriteMovieYears() -> [Int] {
        var years: [Int] = []
        let yearsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MovieModel.entityName)
        yearsRequest.propertiesToFetch = [MovieModel.year]
        
        do {
            let result = try context.fetch(yearsRequest)
            if let mos = result as? [NSManagedObject] {
                for mo in mos {
                    if let year = mo.value(forKey: MovieModel.year) as? Int {
                        years.append(year)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return years
    }
    
    static func deleteFavoriteMovie(withId id: Int) {
        let moviesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MovieModel.entityName)
        moviesRequest.returnsObjectsAsFaults = false
        moviesRequest.predicate = NSPredicate(format: "\(MovieModel.id) == %d", id)
        
        do {
            let result = try context.fetch(moviesRequest)
            if let mos = result as? [NSManagedObject] {
                if mos.count > 0 {
                    context.delete(mos.first!)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        saveContext()
    }
    
    static func isFavoriteMovie(id: Int) -> Bool {
        var movies: [Movie] = []
        let moviesRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MovieModel.entityName)
        moviesRequest.returnsObjectsAsFaults = false
        moviesRequest.predicate = NSPredicate(format: "\(MovieModel.id) == %d", id)
        
        do {
            let result = try context.fetch(moviesRequest)
            if let mos = result as? [NSManagedObject] {
                for mo in mos {
                    if let movie = movie(mo) {
                        movies.append(movie)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return movies.count > 0
    }
    
}
