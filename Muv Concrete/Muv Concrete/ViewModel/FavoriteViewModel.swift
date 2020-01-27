//
//  FavoriteViewModel.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 24/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class FavoriteViewModel {
    
    var delegate: UIViewController?
    
    var arrayMovies: [MovieCoreData] = []
    var arrayMoviesSave: [MovieCoreData] = []
    
    public func readCoreData(completionHandler: @escaping (Bool) -> Void) {
        let coreData = CoreData()
        if coreData.getElementCoreData() != nil {
            arrayMoviesSave = coreData.getElementCoreData()!
            arrayMovies = arrayMoviesSave
            completionHandler(true)
        }
        
    }

    public func unfavorite(movie: MovieCoreData) {
        let id = movie.id
        let defaults = UserDefaults.standard
        let coreData = CoreData()
        let arrayFavoritesIds = defaults.array(forKey: "favoritesIds")
        var arraySave: [Int32] = []
        if arrayFavoritesIds != nil {
            arraySave = arrayFavoritesIds as! [Int32]
            arraySave = arraySave.filter( {$0 != id })
            coreData.deleteElementCoreData(id: id)
        }
        defaults.set(arraySave, forKey: "favoritesIds")
    }
    
    public func getMovie(indexPath: IndexPath) -> MovieCoreData {
        return arrayMovies[indexPath.row]
    }
    
    public func search(searchText: String, completionHandler: @escaping (Bool) -> Void ) {
        guard !searchText.isEmpty else {
            arrayMovies = arrayMoviesSave
            completionHandler(true)
            return
        }
        arrayMovies = arrayMoviesSave.filter({ movie -> Bool in
            if let movieName = movie.title {
                return movieName.contains(searchText)
            }
            return false
        })
        
        completionHandler(true)
    }
}
