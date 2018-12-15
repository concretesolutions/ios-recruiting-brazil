//
//  MovieDetailWorker.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation

struct MovieDetailWorker {
    var posterPath: String?
    var title: String
    var genreID: String
    var yearOfRelease: String
    var isFavorite: Bool
    var description: String
    var id: Int
    
    init(posterPath: String?, title: String, genreID: String, yearOfRelease: String, isFavorite: Bool, description: String, id: Int) {
        self.posterPath = posterPath
        self.title = title
        self.genreID = genreID
        self.yearOfRelease = yearOfRelease
        self.isFavorite = isFavorite
        self.description = description
        self.id = id
    }
}
