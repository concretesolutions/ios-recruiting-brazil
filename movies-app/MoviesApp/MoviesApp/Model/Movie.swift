//
//  Movie.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 31/05/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let rating: Double?
    let image: String?
    let originalTitle: String?
    let description: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rating = "vote_average"
        case image = "poster_path"
        case originalTitle = "original_title"
        case description = "overview"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        originalTitle = try values.decodeIfPresent(String.self, forKey: .originalTitle)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
    }
}
