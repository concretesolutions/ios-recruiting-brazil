//
//  Movie.swift
//  Movies
//
//  Created by Matheus Ribeiro D'Azevedo Lopes on 30/10/18.
//  Copyright © 2018 Matheus Ribeiro D'Azevedo Lopes. All rights reserved.
//
import Foundation

struct Movie: Codable {
  let identificator: Int
  let title: String
  let posterPath: String
  let voteAverage: Double
  let releaseDate: Date
  var isFavorite: Bool
  let overview: String
  let backdropPath: String
  let genresID: [Int]
}
