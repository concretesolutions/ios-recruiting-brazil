//
//  FavoritesInteractor.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class FavoritesInteractor {

    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var movies:[Movie] {
        let coreDataManager = CoreDataManager<Movie>()
        
        do {
            return try coreDataManager.get()
        } catch {
            Logger.logError(in: self, message: "Could not fetch movies from CoreData")
            return [Movie]()
        }
    }
    
    
    // MARK: Init
    
    // MARK: - Functions
    // MARK: Private
    
    // MARK: Public
    func set(movie:Movie, isFavorited:Bool) {
        movie.isFavorited = isFavorited
    }
}
