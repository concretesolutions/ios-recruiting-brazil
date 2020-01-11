//
//  MovieCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

class MovieColletion {
    private var movies = [Movie]()
    
    var count: Int {
        get {
            return movies.count
        }
    }
    
    func addMovies(_ movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }
    
    func movie(for row: Int) -> Movie? {
        return movies[safeIndex: row]
    }
}


extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }

        return self[index]
    }
}
