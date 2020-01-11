//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let title: String
    let posterPath: String?
    var posterURL: URL {
        return URL(safeString: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
    }
}
