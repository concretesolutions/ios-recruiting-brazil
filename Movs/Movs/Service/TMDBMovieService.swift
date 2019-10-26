//
//  TMDBMovieService.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class TMDBMovieService: MovieServiceProtocol {
    func fectchPopularMovies(completed: @escaping (Bool, APIError?, [Movie]) -> ()) {
        // TODO: implement API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let movies = [
                Movie(withTitle: "Steve Universe: The Movie", andPoster: "stevenPoster"),
                Movie(withTitle: "Steve Universe Future", andPoster: "stevenPoster"),
                Movie(withTitle: "Steve Universe", andPoster: "stevenPoster"),
                Movie(withTitle: "Steve", andPoster: "stevenPoster"),
            ]
            completed(true, nil, movies)
        }
    }
}
