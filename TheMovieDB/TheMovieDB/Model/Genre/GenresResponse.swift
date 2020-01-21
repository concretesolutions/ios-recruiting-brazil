//
//  GenresResponse.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 16/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [GenreResponse]
}
