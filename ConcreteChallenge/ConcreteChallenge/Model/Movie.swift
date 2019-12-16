//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

struct Movie: Decodable {
    var id: Int
    var title: String
    var genreIDs: [Int]
    var popularity: Double
    var posterPath: String
    var overview: String
    var posterImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case popularity, id, title, overview
        case genreIDs = "genre_ids"
        case posterPath = "poster_path"
    }
}
