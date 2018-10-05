//
//  MovieModel.swift
//  TMDBMoviesSample
//
//  Created by Breno Rage Aboud on 04/10/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class MovieModel: Decodable {
    
    var posterPath: String?
    var title: String?
    var releaseDate: String?
    var id: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
