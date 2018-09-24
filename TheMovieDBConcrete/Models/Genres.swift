//
//  Genres.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Genres: NSObject {

    var genresArray: [Genre]
    
    override init() {
        genresArray = []
    }
    init(genresInInt genres: [Int]) {
        genresArray = []
        for genre in genres {
            let singleGenre = Genre(genreId: genre)
            genresArray.append(singleGenre)
        }
    }
}
