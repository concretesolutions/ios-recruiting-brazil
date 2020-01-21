//
//  Movie.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 20/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import Combine
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    @NSManaged var movieID: String?
    @NSManaged var title: String?
    @NSManaged var overview: String?
    @NSManaged var posterPath: String?
    @NSManaged var genres: [Int]?
    @NSManaged var isFavorite: Bool
    @NSManaged var releaseDate: String?
 
    public var notification = PassthroughSubject<Void, Never>()
}

public class MovieAdapter {
    static func parseMovies(_ responseMovies: [MovieResponse], completion: @escaping ([Movie]) -> Void) {
        var movies = [Movie]()
        CoreDataManager.shared.foregroundOperation { (context) in
            for response in responseMovies {
                let entity = Movie.entity()
                guard let newMovie = NSManagedObject(entity: entity,
                                                     insertInto: nil) as? Movie else { continue }
                newMovie.title = response.title
                newMovie.overview = response.overview
                newMovie.posterPath = response.posterPath
                newMovie.releaseDate = response.releaseDate
                newMovie.movieID = "\(response.id)"
                newMovie.genres = response.genres
                newMovie.isFavorite = false
                movies.append(newMovie)
            }
            completion(movies)
        }
    }
    
    static func saveMovie(_ movie: Movie) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context, let id = movie.movieID  else { return }
            getMovie(withMovieID: id, inContext: managedContext, result: { (movieReturn) in
                guard movieReturn == nil else {
                    return }
                managedContext.insert(movie)
                do {
                    try managedContext.save()
                }catch{
                    managedContext.redo()
                }
            })
        }
    }
    
    static func updateMovie(movieID: String, toFavorite: Bool) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context else { return }
            getMovie(withMovieID: movieID, inContext: managedContext) { (movie) in
                do {
                    if let updateMovie = movie {
                        updateMovie.isFavorite = toFavorite
                        if managedContext.hasChanges {
                            try managedContext.save()
                        }
                    }
                } catch{
                    managedContext.redo()
                }
            }
        }
    }
    
    static func getMovie(withMovieID id: String, inContext context: NSManagedObjectContext, result: @escaping (Movie?) -> Void) {
        let predicate = NSPredicate.init(format: "movieID == %@", id)
        let request = Movie.fetchRequest()
        request.predicate = predicate
        var movie: Movie?
        do {
            movie = try context.fetch(request).first as? Movie
            result(movie)
        }catch{
            result(nil)
        }
    }
    
    static func getAllMovies(isFavorites favorites: Bool = false, result: @escaping ([Movie]?) -> Void) {
        CoreDataManager.shared.foregroundOperation { (context) in
            guard let managedContext = context else { return }
            let request = Movie.fetchRequest()
            if favorites {
                let predicate = NSPredicate.init(format: "isFavorite == %@", favorites)
                request.predicate = predicate
            }
            do {
                let movies = try managedContext.fetch(request) as? [Movie]
                result(movies)
            }catch {
                result(nil)
            }
        }
    }
}
