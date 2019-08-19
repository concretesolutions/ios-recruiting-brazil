//
//  Movie.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation

struct Movie:Codable {
    var id:Int
    var title:String
    var posterPath:String
    var genreIds: Array<Int>
    var overview: String
    var releaseDate:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case genreIds = "genre_ids"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.posterPath = try values.decode(String.self, forKey: .posterPath)
        self.genreIds = try values.decode(Array<Int>.self, forKey: .genreIds)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.releaseDate = try values.decode(String.self, forKey: .releaseDate)
    }
}

struct MovieResponse:Codable {
    var results:Array<Movie>
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try values.decode(Array<Movie>.self, forKey: .results)
    }
}

