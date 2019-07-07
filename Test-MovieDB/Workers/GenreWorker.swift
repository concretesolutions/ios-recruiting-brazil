//
//  GenreWorker.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 16/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct GenreWorker: Codable {
    var genres: [Genres]
}

struct Genres: Codable {
    var id: Int
    var name: String
}
