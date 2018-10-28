//
//  MovieDetailed.swift
//  Movs
//
//  Created by Maisa on 25/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

struct MovieDetailed {
    let id: Int
    let genres: [Genre]
    var genresNames: [String]
    let title: String
    let overview: String
    let releaseDate: String
    var posterPath: String
    let voteAverage: Double
    
    var isFavorite: Bool
}

extension MovieDetailed: Decodable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case genres = "genres"
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        genres = try container.decode([Genre].self, forKey: .genres)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        // TODO: format the release date
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        
        isFavorite = false
        genresNames = [""]
    }
}

extension MovieDetailed {
    
    enum MovieCoreDataKey: String {
        case id = "id"
        case genres = "genres"
        case title = "title"
        case overview = "overview"
        case releaseDate = "releaseYear"
        case posterPath = "posterPath"
        case voteAverage = "voteAverage"
    }
    
}
