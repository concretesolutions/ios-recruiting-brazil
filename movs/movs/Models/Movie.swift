//
//  Movie.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

struct Movie: Codable {
    let name: String
    let movieId: Int
    let description: String
    let imagePath: String

    enum CodingKeys: String, CodingKey {
        case name = "original_title"
        case movieId = "id"
        case description = "overview"
        case imagePath = "poster_path"
    }
}
