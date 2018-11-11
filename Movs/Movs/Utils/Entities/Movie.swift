//
//  Movie.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let poster_path: String
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids: [Int]
    let id: Int
    let original_title: String
    let original_language: String
    let title: String
    let backdrop_path: String
    let popularity: Int
    let vote_count: Int
    let video: Bool
    let vote_average: Double
//    private enum CodingKeys: String, CodingKey {
//        case poster_path
//        case adult
//    }
}


