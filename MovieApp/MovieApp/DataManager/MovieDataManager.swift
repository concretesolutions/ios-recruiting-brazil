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
        let container = NSPersistentContainer(name: "MovieData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var arrayMovieData: [MovieData] = []
    
    func saveMovieCoreData(movie: MovieData) {
        
        let context = persistentContainer.viewContext
        let movieData = MovieData(context: context)
        
        movieData.title = movie.title
        movieData.releaseDate = movie.releaseDate
        movieData.overview = movie.overview
        movieData.imageURL = movie.imageURL
        movieData.genres = movie.genres
        movieData.id = movie.id
        
        do {
            try context.save()
        } catch {
            print("Error - DataManager - saveMovie() ")
        }
        
    }
    
    func saveMovie(movieToSave: Movie, genres: String) {
        
        let context = persistentContainer.viewContext
        let movie = MovieData(context: context)
        
        movie.title = movieToSave.title
        movie.releaseDate = movieToSave.releaseDate
        movie.overview = movieToSave.overview
        movie.imageURL = movieToSave.backdropPath
        movie.genres = genres
        movie.id = Int64(movieToSave.id)
        
        do {
            try context.save()
        } catch {
            print("Error - DataManager - saveMovie() ")
        }
    }
    
    func loadMovie(completion: ([MovieData]) -> Void) {
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieData")
        let result = try? context.fetch(request)
        arrayMovieData = result as? [MovieData] ?? []
        completion(arrayMovieData)
    }
    
    func delete(id: NSManagedObjectID, completion: (Bool) -> Void) -> Void {
        let context = persistentContainer.viewContext
        let object = context.object(with: id)
        
        context.delete(object)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
    
    func mergeMovies(movies: [Movie]) -> [Movie] {
        loadMovie { (movieCore) in
            self.arrayMovieData = movieCore
        }
        
        var moviesWithFavoretes: [Movie] = []
        movies.forEach { (movie) in
            
            let movieFavorite = arrayMovieData.first {
                return $0.id == Int64(movie.id)
            }
            
            if movieFavorite != nil { movie.isFavorite = true  }
            moviesWithFavoretes.append(movie)
        }
        
        return moviesWithFavoretes
        
    }
    
    func isMovieFavorite(id: Int) -> Bool {
        loadMovie { (movieCore) in
            self.arrayMovieData = movieCore
        }
        
        let movie = arrayMovieData.first { (movieData) -> Bool in
            return movieData.id == Int64(id)
        }
        return movie != nil
    }
}
