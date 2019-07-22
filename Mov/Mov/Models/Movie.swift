//
//  Movie.swift
//  Mov
//
//  Created by Victor Leal on 22/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import Foundation

// MARK: - Empty
struct Empty: Decodable {
    // let page, totalResults, totalPages: Int?
    let results: [Result]?
}

// MARK: - Result
struct Result: Decodable {
    let voteCount, id: Int?
    let video: Bool?
    let voteAverage: Double?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let originalLanguage: OriginalLanguage?
    let originalTitle: String?
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool?
    let overview, releaseDate: String?
}

enum OriginalLanguage: String, Decodable {
    
    case en = "en"
    case ja = "ja"
    case ta = "ta"
}

