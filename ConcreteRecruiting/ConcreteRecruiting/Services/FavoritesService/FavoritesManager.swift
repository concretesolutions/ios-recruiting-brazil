//
//  FavoritesManager.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 12/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import Foundation

protocol FavoritesManager {
    
    associatedtype Model
    associatedtype List
    
    func checkForPresence(of model: Model) -> Bool
    
    func addFavorite(_ model: Model)
    
    func removeFavorite(_ model: Model)
    
    func getAllFavorites() -> List
    
}
