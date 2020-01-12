//
//  FavoritesManager.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

protocol FavoriteMoviesManager {
    
    func checkForPresence(of movie: Movie) -> Bool
    
    func addFavorite(_ movie: Movie)
    
    func removeFavorite(_ movie: Movie)
    
    func getAllFavorites() -> [Int]
    
}
