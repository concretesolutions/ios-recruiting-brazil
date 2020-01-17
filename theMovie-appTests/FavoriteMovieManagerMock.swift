//
//  FavoriteMovieManagerMock.swift
//  theMovie-appTests
//
//  Created by Adriel Alves on 16/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@testable import theMovie_app

class FavoriteMovieManagerMock: FavoriteMoviesManagerProtocol {
    
    var addFavoriteCalled: Bool = false
    var deleteFavoriteCalled: Bool = false
    
    var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func buildFavoriteMovieData() -> [FavoriteMovieData] {
        
        var favoriteMovies: [FavoriteMovieData] = []
        var favoriteMovieData: FavoriteMovieData!
        
        favoriteMovieData = FavoriteMovieData(context: managedObjectContext)
        favoriteMovieData.movieTitle = "Captain Marvel"
        favoriteMovieData.movieYear = "0000"
        favoriteMovieData.movieDetails = "Voa e solta raio"
        favoriteMovieData.moviePoster = UIImage(named: "images")
        favoriteMovieData.id = 111
        
        var favoriteMovieData2: FavoriteMovieData!
        favoriteMovieData2 = FavoriteMovieData(context: managedObjectContext)
        favoriteMovieData2.movieTitle = "Iron Man"
        favoriteMovieData2.movieYear = "1000"
        favoriteMovieData2.movieDetails = "Genio bilionario playboy filantropo"
        favoriteMovieData2.moviePoster = UIImage(named: "images")
        favoriteMovieData2.id = 222
        
        favoriteMovies.append(contentsOf: [favoriteMovieData, favoriteMovieData2])
        
        return favoriteMovies
    }
    
    func favoriteMovieFetched(index: Int64) -> [FavoriteMovieData] {
        var result: [FavoriteMovieData] = []
        
        for favoriteMovie in buildFavoriteMovieData() {
            
            if favoriteMovie.id == index {
                result.append(favoriteMovie)
            }
        }
        
        return result
    }
    
    func favoriteMovieFetched(filtering: String = "") -> [FavoriteMovieData] {
        var result: [FavoriteMovieData] = []
        
        for favoriteMovie in buildFavoriteMovieData() {
            
            if favoriteMovie.movieTitle == filtering {
                result.append(favoriteMovie)
            }
        }
        
        return result
    }
    
    func fetch(filtering: String = "") -> [FavoriteMovieData]? {
        
        return favoriteMovieFetched(filtering: filtering)
    }
    
    func fetchById(index: Int64) -> [FavoriteMovieData]? {
        return favoriteMovieFetched(index: index)
    }
    
    func addFavoriteMovie(movieVM: MovieViewModel) {
        addFavoriteCalled = true
    }
    
    func delete(id: Int64) {
        deleteFavoriteCalled = true
    }
    
}
