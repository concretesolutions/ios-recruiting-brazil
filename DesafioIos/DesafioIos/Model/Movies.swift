//
//  Movies.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 10/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
// MARK: - Movies
struct Movies: Codable {
    let page, totalResults, totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Movie: Codable{
    let id: Int
    let backdropPath: String
    let genreIDS: [Int]
    let title: String
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case title
        case overview
        case releaseDate = "release_date"
    }

}
