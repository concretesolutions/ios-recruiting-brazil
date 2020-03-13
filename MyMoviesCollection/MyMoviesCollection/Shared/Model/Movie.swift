//
//  Movie.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 13/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let id: Int
    let posterUrl: String
    let overview: String
    let releaseDate: String
    let generedIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case title = "original_title"
        case id
        case posterUrl = "poster_path"
        case overview
        case releaseDate = "release_date"
        case generedIds = "genre_ids"
    }
    
    init(title: String, id: Int, posterUrl: String, overview: String, releaseDate: String, generedIds: [Int]) {
        self.title = title
        self.id = id
        self.posterUrl = posterUrl
        self.overview = overview
        self.releaseDate = String(releaseDate.prefix(4))
        self.generedIds = generedIds
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let id = try container.decode(Int.self, forKey: .id)
        let posterUrl = try container.decode(String.self, forKey: .posterUrl)
        let overview = try container.decode(String.self, forKey: .overview)
        let releaseDate = try container.decode(String.self, forKey: .releaseDate)
        let generedIds = try container.decode([Int].self, forKey: .generedIds)
        self.init(title: title, id: id, posterUrl: posterUrl, overview: overview, releaseDate: releaseDate, generedIds: generedIds)
    }
    
}
