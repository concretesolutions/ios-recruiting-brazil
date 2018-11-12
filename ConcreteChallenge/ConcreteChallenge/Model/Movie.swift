//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 12/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class Movie {
    
    // MARK: - Properties
    let id: Int
    let title: String
    let posterPath: String
    let genreIds: [Int]
    let overview: String
    let releaseDate: Date
    
    
    // MARK: - Decodable Keys
    enum MovieDecodableKey: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    init(id: Int, title: String, posterPath: String, genreIds: [Int], overview: String, releaseDate: Date) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.genreIds = genreIds
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDecodableKey.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let title: String = try container.decode(String.self, forKey: .id)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let genreIds: [Int] = try container.decode([Int].self, forKey: .genreIds)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let releaseDate: Date = try container.decode(Date.self, forKey: .releaseDate)
        
        self.init(id: id, title: title, posterPath: posterPath, genreIds: genreIds, overview: overview, releaseDate: releaseDate)
    }

}
