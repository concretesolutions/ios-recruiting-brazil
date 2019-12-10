//
//  Movie.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

struct Movie: Codable {
    let id: Int
    var video: Bool?
    let voteCount: Int
    let voteAverage: Double
    var title, releaseDate, originalLanguage, originalTitle: String?
    var genreIDS: [Int]?
    var backdropPath: String?
    var adult: Bool?
    let overview: String
    var posterPath: String?
    let popularity: Double
    var mediaType: String?
}
