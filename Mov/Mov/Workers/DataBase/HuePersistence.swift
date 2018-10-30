//
//  HuePersistence.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

class HuePersistence: MoviePersistence {
    
    private (set) var pagesFetch: Int = 0
    
    var fetchedMovies: [Movie] = [Movie]()
    
    
    func isFavorite(_ movie: Movie) -> Bool {
        return true
    }
    
    func shouldFetchMovies(forPage page: Int) -> Bool {
        return page > self.pagesFetch
    }
    
    func incrementPagesFetch() {
        self.pagesFetch += 1
    }
}
