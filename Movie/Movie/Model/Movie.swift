//
//  Movie.swift
//  Movie
//
//  Created by Gustavo Pereira Teixeira Quenca on 19/07/19.
//  Copyright © 2019 Gustavo Pereira Teixeira Quenca. All rights reserved.
//

import Foundation

class MovieArray: Codable {
    let movieScreen = [Movie]()
}

class GenreListResult: Codable {
    let genres: [Genre]
}

class Genre: Codable {
    let id: Int?
    let name: String?
}

class MovieListResult: Codable {
    let page: Int?
    var results: [Movie]?
    let total_results: Int?
    let total_pages: Int?
}

struct Movie: Codable {
    
    let poster_path: String?
    let adult: Bool?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let video: Bool?
    let vote_average:Double?
    
    var isFavorite: Bool = false
    
    enum CodingKeys: CodingKey {
        case poster_path
        case adult
        case overview
        case release_date
        case genre_ids
        case id
        case original_title
        case original_language
        case title
        case backdrop_path
        case popularity
        case vote_count
        case video
        case vote_average
    }
}
