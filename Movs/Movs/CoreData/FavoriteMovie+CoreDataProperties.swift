//
//  FavoriteMovie+CoreDataProperties.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteMovie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovie> {
        return NSFetchRequest<FavoriteMovie>(entityName: "FavoriteMovie")
    }

    @NSManaged public var coverPath: String?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var title: String?
    @NSManaged public var year: String?
    @NSManaged public var genres: String?
    
    static func addFavoriteMovie(movieViewModel: MovieViewModel){
        let defaults = UserDefaults.standard
        var favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        
        let favoriteMovie = NSEntityDescription.insertNewObject(forEntityName: String(describing: FavoriteMovie.self), into: PersistenceService.context) as! FavoriteMovie
        
        favoriteMovie.id = Int64(movieViewModel.id)
        favoriteMovie.title = movieViewModel.title
        favoriteMovie.coverPath = movieViewModel.coverPath
        favoriteMovie.overview = movieViewModel.description
        favoriteMovie.year = movieViewModel.releaseDate
        favoriteMovie.genres = movieViewModel.genres
        PersistenceService.saveContext()
        
        favoriteMoviesId.append(movieViewModel.id)
        defaults.set(favoriteMoviesId, forKey: "favoriteMoviesId")
    }
    
    static func removeFavoriteMovie(id: Int){
        let defaults = UserDefaults.standard
        var favoriteMoviesId = defaults.array(forKey: "favoriteMoviesId") as? [Int] ?? []
        
        PersistenceService.deleteMovieBy(id: id)
        
        favoriteMoviesId = favoriteMoviesId.filter { $0 != id }
        defaults.set(favoriteMoviesId, forKey: "favoriteMoviesId")
    }
    
}
