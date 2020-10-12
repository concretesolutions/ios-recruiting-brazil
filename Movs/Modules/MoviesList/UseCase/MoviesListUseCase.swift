//
//  MoviesListUseCase.swift
//  Movs
//
//  Created by Joao Lucas on 11/10/20.
//

import Foundation
import RealmSwift

class MoviesListUseCase {
    
    func addToFavorites(realm: Realm, movie: ResultMoviesDTO,
                        onSuccess: @escaping (() -> Void)) {
        
        realm.beginWrite()
                
        let newFavorite = FavoriteEntity()
        newFavorite.id = movie.id
        newFavorite.title = movie.title
        newFavorite.photo = movie.poster_path
        newFavorite.genre = Constants.getGenresString(movies: movie)!
        newFavorite.year = Constants.getYear(movies: movie)
        realm.add(newFavorite)
                
        try! realm.commitWrite()
        
        onSuccess()
    }
    
    func removeFavorites(realm: Realm, movie: ResultMoviesDTO,
                         onSuccess: @escaping (() -> Void)) {
        
        if let userObject = realm.objects(FavoriteEntity.self).filter("id == \(movie.id)").first {
            try! realm.write {
                realm.delete(userObject)
            }
            
            onSuccess()
        }
    }
    
}
