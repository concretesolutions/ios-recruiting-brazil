// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieDetail = try? newJSONDecoder().decode(MovieDetail.self, from: jsonData)

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let genres: [Genre]
    let id: Int
    let originalTitle, overview: String
    let posterPath: String
    let releaseDate: String
   

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case id
        case genres
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
