//
//  UserFavorites.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 20/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

class UserFavorites {
    static let shared = UserFavorites()
    
    var favorites: [Int] = []
    
    private init() {
        favorites = UserDefaults.standard.object(forKey: "favorites") as! [Int]
    }
    
    func add(id: Int) {
        favorites.append(id)
    }
    
    func remove(id: Int) {
        favorites = favorites.filter{ $0 != id }
    }
    
    func save() {
        UserDefaults.standard.set(favorites, forKey: "favorites")
    }
}
