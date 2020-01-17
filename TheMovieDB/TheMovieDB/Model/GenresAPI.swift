//
//  GenresAPI.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 16/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

class GenresAPI: Decodable {
    let genres: [Genre]

    init(genres: [Genre]) {
        self.genres = genres
    }
}
