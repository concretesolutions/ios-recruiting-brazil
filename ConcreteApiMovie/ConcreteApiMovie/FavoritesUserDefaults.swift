//
//  FavoritesUserDefaults.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 20/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class FavoritesUserDefaults {
    
    let favoriteMoviesKey = "favoriteMovieslist"
    var moviesArray:[Int] = []
    
    func showFavoritesMovie() -> Array<Int>{
        let data = UserDefaults.standard.object(forKey: favoriteMoviesKey)
        if data != nil{
            return data as! Array
        }else {
            return []
        }
    }

    func addFavoriteMovie(movie: Int){
        moviesArray = showFavoritesMovie()//recover movies before save
        moviesArray.append(movie)//add movies
        UserDefaults.standard.set(moviesArray, forKey: favoriteMoviesKey)
    }

    func removeFavoriteMovie(index:Int){
        moviesArray = showFavoritesMovie()//recover all movies before delete
        moviesArray.remove(at: index)
        UserDefaults.standard.set(moviesArray, forKey: favoriteMoviesKey)
    }
    
    func clearUserDefaults() {
        UserDefaults.standard.removeObject(forKey: favoriteMoviesKey)
    }
}
