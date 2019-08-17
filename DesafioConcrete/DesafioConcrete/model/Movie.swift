//
//  Movie.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation

struct Movie:Codable {
    var id:String
    var title:String
    var poster_path:String
    var genreIds: Array<Int>
    var overview: String
    var release_date:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case poster_path = "poster_path"
        case genreIds = "genreIds"
        case overview = "overview"
        case release_date = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.poster_path = try values.decode(String.self, forKey: .poster_path)
        self.genreIds = try values.decode(Array<Int>.self, forKey: .genreIds)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.release_date = try values.decode(String.self, forKey: .release_date)
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

