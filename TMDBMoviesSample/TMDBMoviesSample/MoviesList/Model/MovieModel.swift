//
//  MovieModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieModel: Decodable {
    
    var title: String?
    var releaseDate: String?
    var id: Int?
    var posterPath: String?
    var posterImageData: Data?
    var backdropPath: String?
    var description: String?
    var genreIds: [Int]?
    var isFav: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case id
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case description = "overview"
        case genreIds = "genre_ids"
    }
}
