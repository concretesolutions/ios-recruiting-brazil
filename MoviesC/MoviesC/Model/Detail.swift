//
//  Detail.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation

struct Detail: Codable, Equatable {
    let overview: String
    let id: Int
    let genres: [Genre]
    let title: String
    let posterPath: String
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case overview
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres
    }
    
    static func ==(lhs: Detail, rhs: Detail) -> Bool {
        return lhs.id == rhs.id
    }
    
}

struct Genre: Codable {
    let id: Int
    let name: String
}
