//
//  HomeManager.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

protocol HomeInterfaceProtocol {
    func set(state: HomeInterfaceState)
    func reload()
}

class HomeManager {
    var interface: HomeInterfaceProtocol?
    var provider = HomeProvider()
    
    var movies = [Movie]()
    var page = 1
    
    
    init(_ interface: HomeInterfaceProtocol) {
        self.interface = interface
        self.provider.delegate = self
    }
    
    func fetchMovies() {
        self.provider.fetchPopularMovies(page: page) { movies in
            
            self.movies = movies
            self.interface?.reload()
        }
    }
    
    func numberOfMovies() -> Int {
        return self.movies.count
    }
    
    func movieIn(index: Int) -> Movie? {
        return self.movies[index]
    }
}

extension HomeManager: HomeProviderDelegate {
    func handler(badRequest: BadRequest) {
        
        
        
    }
}
