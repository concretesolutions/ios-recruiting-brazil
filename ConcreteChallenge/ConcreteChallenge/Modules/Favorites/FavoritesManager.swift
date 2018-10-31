//
//  FavoritesManager.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavoritesInterfaceProtocol {
    func set(state: FavoritesInterfaceState)
    func reload()
}

class FavoritesManager {
    var interface: FavoritesInterfaceProtocol?
    
    let realm: Realm!
    
    var movies: [Movie] = []
    
    init(_ interface: FavoritesInterfaceProtocol) {
        self.realm = try! Realm()
        self.interface = interface
        self.load()
    }
    
    func load() {
        let movies = self.realm.objects(Movie.self)
        self.movies = Array(movies)
    }
    
    func numberOfMovies() -> Int {
       return movies.count
    }
    
    func movieIn(index: Int) -> Movie {
        return movies[index]
    }
}
