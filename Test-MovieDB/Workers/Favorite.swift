//
//  Favorite.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct Favorite {
    var title: String
    var description: String
    var posterPath: String?
    var isFavorite: Bool
    var genreID: [Int]
    var yearOfRelease: String
    var id: Int
    
    init(title: String, description: String, posterPath: String?, isFavorite: Bool, genreID: [Int], yearOfRelease: String, id: Int) {
        self.title = title
        self.description = description
        self.posterPath = posterPath
        self.isFavorite = isFavorite
        self.genreID = genreID
        self.yearOfRelease = yearOfRelease
        self.id = id
    }
}

