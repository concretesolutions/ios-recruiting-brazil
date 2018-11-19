//
//  CDMovieDAO.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 12/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import CoreData

final class CDMovieDAO{
    
    static func create(from movie:Movie)->CDMovie{
        let persistedMovie = CDMovie.newMovie()
        persistedMovie.id = Int32(movie.id)
        persistedMovie.title = movie.title
        persistedMovie.posterPath = movie.posterPath
        persistedMovie.voteAverage = movie.voteAverage
        persistedMovie.releaseDate = movie.releaseData
        DatabaseManager.saveContext()
        return persistedMovie
    }
    
    static func getAll() ->[CDMovie]{
        var persistedMovies:[CDMovie] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PersistedEntity.movie)

        do{
            persistedMovies = try DatabaseManager.getContext().fetch(fetchRequest) as! [CDMovie]
        }catch let error{
            print(error.localizedDescription)
        }
        
        return persistedMovies
    }
    
    static func hasFavoriteMovie(with id:Int) -> Bool{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PersistedEntity.movie)
        let predicate = NSPredicate(format: "id == \(id)")
        fetchRequest.predicate = predicate
        
        do{
            let movies = try DatabaseManager.getContext().fetch(fetchRequest)
            if movies.count > 0{
                return true
            }else{
                return false
            }
        }catch{
            return false
        }
    }
    
    static func unfavoriteMovie(movie: CDMovie){
        DatabaseManager.getContext().delete(movie)
        DatabaseManager.saveContext()
    }
}
