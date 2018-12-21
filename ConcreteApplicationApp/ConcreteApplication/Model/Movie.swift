//
//  Movie.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit

struct Movie{
    
    var id: Int
    var title: String
    var posterPath: String?
    var genres: [Genre]
    var overview: String
    var releaseYear: String
    var isFavorite = false
    var poster: UIImage?
    
    
    public init(id: Int,
                title: String,
                posterPath: String,
                overview: String,
                releaseYear: String,
                genres: [Genre]){
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseYear = releaseYear
        self.genres = genres
    }
}

extension Movie:Codable{
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case posterPath = "poster_path"
        case genres = "genre_ids"
        case overview
        case releaseYear = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        
        let releaseDate = try container.decode(String.self, forKey: .releaseYear)
        if !releaseDate.isEmpty {
            releaseYear = String(releaseDate.prefix(4))
        } else {
            releaseYear = "Unknown"
        }
        
        genres = [Genre]()
        let ids = try container.decode([Int].self, forKey: .genres)
        ids.forEach({ self.genres.append(Genre(id:$0)) })

    }
}
