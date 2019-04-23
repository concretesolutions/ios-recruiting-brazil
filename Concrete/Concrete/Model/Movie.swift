// To parse the JSON, add this file to your project and do:
//
//   let movies = try? newJSONDecoder().decode(Movies.self, from: jsonData)

import UIKit
import RealmSwift

struct Movies: Codable {
    let page, totalResults, totalPages: Int
    var results: [Result]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

class Result: Codable {
    let idMovie: Int?
    let overview: String?
    let title: String?
    let posterPath: String?
    let genreIDS: [Int]?
    let releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case idMovie = "id"
        case title
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }
}
