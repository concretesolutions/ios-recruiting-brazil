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
    
    static func create(from movie:Movie, genres:[Genre], callback: @escaping (CDMovie?, Error?)->Void){
        
        if hasFavoriteMovie(with: movie.id){
            callback(nil, NSError(domain: "Core Data", code: 406, userInfo: nil))
        }else{
            let persistedMovie = CDMovie.newMovie()
            persistedMovie.id = Int32(movie.id)
            persistedMovie.title = movie.title
            persistedMovie.posterPath = movie.posterPath
            persistedMovie.voteAverage = movie.voteAverage
            persistedMovie.releaseDate = movie.releaseDate
            persistedMovie.overview = movie.overview
            persistedMovie.genres = []
            for genre in genres where movie.genres.contains(genre.id){
                persistedMovie.genres?.append(genre.name)
            }
            
            DatabaseManager.saveContext()
            
            callback(persistedMovie, nil)
        }
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
    
    static func fetchMovies(with title:String) -> [CDMovie]{
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PersistedEntity.movie)
        let predicate = NSPredicate(format: "title contains[c] %@", title)
        fetchRequest.predicate = predicate
        
        do{
            let movies = try DatabaseManager.getContext().fetch(fetchRequest)
            return movies as! [CDMovie]
        }catch{
            return []
        }
        
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
    
    static func getPersistedYears(callback: @escaping ([String], Error?)->Void){
        var years:[String] = []
        
        let persistedMovies = self.getAll()
        for elem in persistedMovies{
            let year = elem.getYear()
            if !years.contains(year){
                years.append(year)
            }
        }
        years = years.sorted { (year1, year2) -> Bool in
            year1 < year2
        }
        callback(years, nil)
    }
    
    static func getPersistedGenres(callback: @escaping ([String], Error?) -> Void){
        
        var genres:[String] = []
        
        let persistedMovies = self.getAll()
        for movie in persistedMovies{
            if let movieGenres = movie.genres{
                for persistedGenre in movieGenres{
                    if !genres.contains(persistedGenre){
                        genres.append(persistedGenre)
                    }
                }
            }
        }
        callback(genres.sorted(), nil)
    }
}
