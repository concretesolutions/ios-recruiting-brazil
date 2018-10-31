//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    var id: Int?
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var overview: String?
    var release_date: String?
    var saved: Bool? = false
}
