//
//  Movie.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation
import Moya

struct Movie {
    let id: Int
    let genresId: [Int]
    let title: String
    let overview: String
    let releaseDate: String
    let posterPath: String
    
}

extension Movie: Decodable {
    enum MovieCodingKeys: String, CodingKey {
        case id = "id"
        case genresId = "genre_ids"
        case title = "title"
        case overview = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
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
        
    }
}
