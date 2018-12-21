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
    let genres_ids: [Int]?
    let releaseDate: String?
    let genres: [Genre]?
    
    init(movieResult: MovieResult) {
        self.id = movieResult.id
        self.title = movieResult.title
        self.posterPath = movieResult.poster_path
        self.description = movieResult.overview
        self.genres_ids = movieResult.genre_ids
        self.genres = movieResult.genres
        
        if let releaseDate = movieResult.release_date {
            let index = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
            self.releaseDate = String(releaseDate[..<index])
        } else {
            self.releaseDate = nil
        }
    }
}
