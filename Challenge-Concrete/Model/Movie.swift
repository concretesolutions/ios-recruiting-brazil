//
//  Movie.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import Foundation

class Movie: Codable {
    let id: Int
    var title, name, releaseDate, originalTitle, originalName: String?
    var genreIDS: [Int]?
    let overview: String
    var posterPath: String?
    var mediaType: String?
    
    var movieImageData: Data?
    var isFavorite: Bool? = false
}

struct MovieImage {
    let movieId: Int
    let imageData: Data
}
