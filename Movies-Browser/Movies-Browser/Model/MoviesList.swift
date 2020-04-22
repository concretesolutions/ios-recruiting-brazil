//
//  MoviesList.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 21/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

struct MoviesList: Codable {
    var movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
