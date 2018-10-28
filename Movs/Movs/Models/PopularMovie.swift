//
//  PopularMovie.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation
import Moya

struct PopularMovie {
    let id: Int
    let genresId: [Int]
    let title: String
    let overview: String
    var releaseDate: String
    var posterPath: String
    let voteAverage: Double
    
    var isFavorite: Bool
}

extension PopularMovie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id
        case genresId = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        genresId = try container.decode([Int].self, forKey: .genresId)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        // TODO: format the release date
        releaseDate = try container.decode(String.self, forKey: .releaseDate)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        
        isFavorite = false
    }
}
