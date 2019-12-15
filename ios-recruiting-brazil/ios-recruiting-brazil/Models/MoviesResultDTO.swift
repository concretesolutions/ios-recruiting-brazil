//
//  MoviesResultDTO.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import Foundation
struct MoviesResultDTO: Codable {
    let movies: [MovieDTO]

    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}
