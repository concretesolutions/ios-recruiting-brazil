//
//  Detail.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import Foundation

struct Detail: Codable {
    let overview: String
    let id: Int
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
