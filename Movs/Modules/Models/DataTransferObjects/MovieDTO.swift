// swiftlint:disable identifier_name

//
//  MovieDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class MovieDTO: Decodable {
    
    // MARK: - Attributes
    
    let id: Int
    let backdropPath: String?
    let genreIDS: [Int]
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let overview: String

    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case id
        case popularity
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case title
        case overview
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(id: Int, backdropPath: String?, genreIDS: [Int], popularity: Double, posterPath: String?, releaseDate: String, title: String, overview: String) {
        self.id = id
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.overview = overview
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDTO.CodingKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let backdropPath: String? = try container.decode(String?.self, forKey: .backdropPath)
        let genreIDS: [Int] = try container.decode([Int].self, forKey: .genreIDS)
        let popularity: Double = try container.decode(Double.self, forKey: .popularity)
        let posterPath: String? = try container.decode(String?.self, forKey: .posterPath)
        let releaseDate: String = try container.decode(String.self, forKey: .releaseDate)
        let title: String = try container.decode(String.self, forKey: .title)
        let overview: String = try container.decode(String.self, forKey: .overview)
        
        self.init(id: id, backdropPath: backdropPath, genreIDS: genreIDS, popularity: popularity, posterPath: posterPath, releaseDate: releaseDate, title: title, overview: overview)
    }
}
