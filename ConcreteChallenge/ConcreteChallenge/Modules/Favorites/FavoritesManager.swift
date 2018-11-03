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
    var movieProvider = MovieProvider()
    var filterProvider = FilterProvider()
   
    
    var movies: [Movie] = []
    var filter: Filter?
    
    init(_ interface: FavoritesInterfaceProtocol) {
        self.interface = interface
    }
    
    func load() {
        self.movies = self.movieProvider.load()
        self.filter = self.filterProvider.load()
        
        self.filter()
    }
    
    func numberOfMovies() -> Int {
       return movies.count
    }
    
    func movieIn(index: Int) -> Movie {
        return movies[index]
    }
    
    func deleteMovieAt(index: Int) {
        self.movieProvider.handle(movie: self.movies[index])
        self.movies.remove(at: index)
    }
    
    func filter(text: String = "") {
        self.movies = self.movieProvider.filteredLoad(text: text, filter: self.filter ?? Filter())
        self.interface?.reload()
    }
}
