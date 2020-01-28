//
//  FavoriteManager.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 27/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteManager {
    let coreData = CoreData()
    let defaults = UserDefaults.standard
    let arrayFavoritesIds = UserDefaults.standard.array(forKey: "favoritesIds")
    var arraySave: [Int32] = []
    
    public func unfavorite(movie: Movie) {
        let id = movie.id
        unfavorite(id: id)
    }
    
    public func unfavorite(id: Int32) {
        if arrayFavoritesIds != nil {
            arraySave = arrayFavoritesIds as! [Int32]
            arraySave = arraySave.filter( {$0 != id })
            coreData.deleteElementCoreData(id: id)
        }
        defaults.set(arraySave, forKey: "favoritesIds")
    }
    
    public func favoriteAction(movie: Movie) {
        let id = movie.id
        if arrayFavoritesIds != nil {
            arraySave = arrayFavoritesIds as! [Int32]
        }
        coreData.saveCoreData(movie: movie)
        arraySave.append(id)
        defaults.set(arraySave, forKey: "favoritesIds")
    }
    
    public func favoriteAction(movie: MovieId) {
        let id = movie.id
        if arrayFavoritesIds != nil {
            arraySave = arrayFavoritesIds as! [Int32]
        }
        coreData.saveCoreData(movie: movie)
        arraySave.append(id)
        defaults.set(arraySave, forKey: "favoritesIds")
    }
    
    public func unfavorite(movie: MovieCoreData) {
        let id = movie.id
        var arraySave: [Int32] = []
        if arrayFavoritesIds != nil {
            arraySave = arrayFavoritesIds as! [Int32]
            arraySave = arraySave.filter( {$0 != id })
            coreData.deleteElementCoreData(id: id)
        }
        defaults.set(arraySave, forKey: "favoritesIds")
    }
}
