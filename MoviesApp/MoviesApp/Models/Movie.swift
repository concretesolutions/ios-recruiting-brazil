//
//  Movie.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

struct Movie:Codable{
    var id:Int
    var title:String
    var posterPath:String?
    var overview:String
    var voteAverage:Float
    var releaseData:String
    var genres:[Int]
    
    enum CodingKeys: String, CodingKey{
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case genres = "genre_ids"
        case id
        case title
        case voteAverage = "vote_average"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(overview, forKey: .overview)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(releaseData, forKey: .releaseDate)
        try container.encode(genres, forKey: .genres)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        posterPath = try values.decode(String?.self, forKey: .posterPath)
        overview = try values.decode(String.self, forKey: .overview)
        voteAverage = try values.decode(Float.self, forKey: .voteAverage)
        releaseData = try values.decode(String.self, forKey: .releaseDate)
        genres = try values.decode([Int].self, forKey: .genres)
    }
}
