//
//  User.swift
//  Movies
//
//  Created by Jonathan Martins on 19/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation

class User{
    
    static let current = User()
    
    var favorites:[Movie] = []
    
    /// Checks if a movie exists in the favorite list
    func isMovieFavorite(movie:Movie) -> Bool{
        let isMovieFavorite = favorites.first(where: {$0.id == movie.id})
        return isMovieFavorite != nil ? true:false
    }
    
    /// Adds or removes a movie from the favorite list
    func favorite(movie: Movie, _ favorite:Bool){
        if favorite {
            favorites.append(movie)
        }
        else{
            if let index = favorites.index(where: {$0.id == movie.id}){
                favorites.remove(at: index)
            }
        }
    }
}
