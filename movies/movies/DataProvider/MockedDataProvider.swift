//
//  MockedDataProvider.swift
//  movies
//
//  Created by Jacqueline Alves on 01/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MockedDataProvider: DataProvidable {
    public static let shared = MockedDataProvider()
    
    var popularMovies: [Movie] = []
    var favoriteMovies: [Movie] {
        return popularMovies.filter { $0.favorite == true }
    }
    
    init() {
        // Initializing movies
        for id in 0..<10 {
            let genres = [Genre(id: id, name: "Action"), Genre(id: 1, name: "Adventure")]
            let movie = Movie(id: 0,
                              title: "The Godfather",
                              posterPath: nil,
                              overview: "The powerful, but arrogant god Thor, is cast out of Asgard to live amongst humans in Midgard (Earth), where he soon becomes one of theur finest defenders.",
                              releaseDate: Date(),
                              genres: genres,
                              favorite: Bool.random())
            
            self.popularMovies.append(movie)
        }
    }
}
