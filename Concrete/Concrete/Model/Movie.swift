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

class Result: Object, Codable {
    @objc dynamic var idMovie: Int = 0
    @objc dynamic var overview: String?
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var isBookmarked: Bool = false
    dynamic var genreIDS: [Int]?
    @objc dynamic var releaseDate: String = ""

    enum CodingKeys: String, CodingKey {
        case idMovie = "id"
        case title
        case posterPath = "poster_path"
        case genreIDS = "genre_ids"
        case overview
        case releaseDate = "release_date"
    }

    override class func primaryKey() -> String? {
        return "idMovie"
    }

    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
        idMovie = try container.decodeIfPresent(Int.self, forKey: .idMovie) ?? 0
        title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath) ?? ""
        genreIDS = try container.decodeIfPresent([Int].self, forKey: .genreIDS)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
    }

    func encode(to encoder: Encoder) throws {

    }
}
