//
//  FavoriteHelper.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

class FavoriteHelper {
    private init() {}
    
    class func getFavorites() -> [FavoriteMovie] {
        do {
            if let favorites = try AppDelegate.shared
                .persistentContainer
                .viewContext
                .fetch(FavoriteMovie.fetchRequest()) as? [FavoriteMovie] {
                return favorites
            }
            return []
        } catch {
            print("Fetching Failed")
            return []
        }
    }
    
    class func setFavorite(movie: Movie) {
        let favoriteMovie = FavoriteMovie(context: AppDelegate.shared.persistentContainer.viewContext)
        favoriteMovie.id = Int64(movie.movieId)
        favoriteMovie.title = movie.title
        favoriteMovie.overview = movie.overview
        favoriteMovie.genreIds = movie.genreIds.compactMap{String($0)}.joined(separator: ",")
        favoriteMovie.posterPath = movie.posterPath
        favoriteMovie.releaseDate = movie.releaseDate
        AppDelegate.shared.saveContext()
    }
    
    class func unfavorite(movie: Movie) {
        if let favoriteMovie = getFavorites().filter({ favorite -> Bool in
            return favorite.id == Int64(movie.movieId)
        }).first {
            AppDelegate.shared
                .persistentContainer
                .viewContext.delete(favoriteMovie)
        }
    }
    
    class func isFavorite(movie: Movie) -> Bool {
        if getFavorites().filter({ favorite -> Bool in
            return favorite.id == Int64(movie.movieId)
        }).isEmpty {
            return false
        }
        return true
    }
}
