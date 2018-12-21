//
//  Movie.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

public class Movie {
    let id: Int?
    let title: String?
    let posterPath: String?
    let description: String?
    let genres: [Int]?
    let releaseDate: String?
    
    init(id: Int, title: String, posterPath: String, description: String, genres: [Int], releaseDate: String) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.description = description
        self.genres = genres
        self.releaseDate = releaseDate
    }
    
    init(movieResult: MovieResult) {
        self.id = movieResult.id
        self.title = movieResult.title
        self.posterPath = movieResult.poster_path
        self.description = movieResult.overview
        self.genres = movieResult.genre_ids
        
        if let releaseDate = movieResult.release_date {
            let index = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
            self.releaseDate = String(releaseDate[..<index])
        } else {
            self.releaseDate = nil
        }
    }
}
