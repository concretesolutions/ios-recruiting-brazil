//
//  MovieDataManager.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 11/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
import CoreData

class MovieDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieSave")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var arrayMovieSave:[MovieSave] = []
    
    
    func saveMovieCoreData(movie: MovieSave) {
        
        let context = persistentContainer.viewContext
        let movieSave = MovieSave(context: context)
        
        movieSave.title = movie.title
        movieSave.releaseDate = movie.releaseDate
        movieSave.overview = movie.overview
        movieSave.imageURL = movie.imageURL
        movieSave.genres = movie.genres
        movieSave.id = movie.id
        
        do {
            try context.save()
        }catch {
            print("Error - DataManager - saveMovie() ")
        }
        
    }
    
    func saveMovie(movieToSave: Movie, genres: String) {
        
        let context = persistentContainer.viewContext
        let movie = MovieSave(context: context)
        
        movie.title = movieToSave.title
        movie.releaseDate = movieToSave.releaseDate
        movie.overview = movieToSave.overview
        movie.imageURL = movieToSave.backdropPath
        movie.genres = genres
        movie.id = Int64(movieToSave.id)
        
        do {
            try context.save()
        }catch {
            print("Error - DataManager - saveMovie() ")
        }
    }
    
    func loadMovie(completion: ([MovieSave])-> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieSave")
        let result = try? context.fetch(request)
        arrayMovieSave = result as? [MovieSave] ?? []
        completion(arrayMovieSave)
    }
    
    func delete(id: NSManagedObjectID, completion: (Bool) -> Void) -> Void {
        let context = persistentContainer.viewContext
        let obj = context.object(with: id)
        
        context.delete(obj)
        do {
            try context.save()
            completion(true)
        }catch {
            completion(false)
        }
    }
    
    func mergeMovies(movies: [Movie]) -> [Movie] {
        loadMovie { (movieCore) in
            self.arrayMovieSave = movieCore
        }
        
        var moviesWithFavoretes: [Movie] = []
        movies.forEach { (movie) in
            
            let movieFavorite = arrayMovieSave.first {
                return $0.id == Int64(movie.id)
            }
            
            if movieFavorite != nil { movie.isFavorite = true  }
            moviesWithFavoretes.append(movie)
        }
        
        return moviesWithFavoretes
        
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        loadMovie { (movieCore) in
            self.arrayMovieSave = movieCore
        }
        
        let movie = arrayMovieSave.first { (movieSave) -> Bool in
            return movieSave.id == Int64(id)
        }
        return movie != nil
    }
}
