//
//  Movie.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let poster_path: String?
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Double
    private enum CodingKeys: String, CodingKey {
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

struct MovieDetail: Codable { // FIXME: - Apagar?
    let adult: Bool?
    let genres: [Genre]? // FIXME: - Lista ID
    let title: String
    let release_date: String
    let poster_path: String
    let overview: String
    let homepage:String?  // FIXME: - Nao precisa
    let id: Int
    private enum CodingKeys: String, CodingKey {
        case id
        case adult
        case genres
        case title
        case release_date
        case poster_path
        case overview
        case homepage
    }
}



