//
//  MoviesDTO.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import Foundation

struct MoviesDTO: Decodable {
    let results: [ResultMoviesDTO]
}

struct ResultMoviesDTO: Decodable {
    let id: Int
    let title: String
    let poster_path: String
    let genre_ids: [Int]
    let release_date: String
    let overview: String
}
