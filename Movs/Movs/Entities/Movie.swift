//
//  Movie.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class Movie: Decodable {
    let title: String
    let releaseDate: String
    let overview: String

    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case overview
    }
}
