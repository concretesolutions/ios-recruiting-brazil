//
//  MovieModel.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

struct MovieApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {

    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)

        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)

    }
}

class Movie: Decodable {
    var id: Int = 0
    var posterPath: String = ""
    var title: String = ""
    var releaseDate: Date?
    var overview: String = ""
    var genres: [String] = []
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case overview
        case genre_ids = "genre_ids"
    }
    
    convenience init(movie: MovieRealm) {
        self.init()
        self.id = movie.id
        self.posterPath = movie.posterPath
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.genres = movie.genres.components(separatedBy: ", ")
    }
    
    convenience init(id: Int, posterPath: String, title: String, releaseDate: Date?, overview: String, genres: [String]) {
        self.init()
        self.id = id
        self.posterPath = posterPath
        self.title = title
        self.releaseDate = releaseDate
        self.overview = overview
        self.genres = genres
    }

    convenience required init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)

        let id = try movieContainer.decode(Int.self, forKey: .id)
        let posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
        let url = "https://image.tmdb.org/t/p/w500" + (posterPath ?? "")
        let title = try movieContainer.decode(String.self, forKey: .title)
        var releaseDate: Date?
        if let dateString = try? movieContainer.decode(String.self, forKey: .releaseDate) {
            let formatter = DateFormatter.yyyyMMdd
            releaseDate = formatter.date(from: dateString) } else {
            releaseDate = nil
        }
        let overview = try movieContainer.decode(String.self, forKey: .overview)
        let genreIDS = try movieContainer.decode([Int].self, forKey: .genre_ids)
        let genresList = genreIDS.map { (id) -> String in
            Genre.fetchedGenres[id] ?? "Uknown"
        }
        self.init(id: id, posterPath: url, title: title, releaseDate: releaseDate, overview: overview, genres: genresList)
    }
}

extension Movie {
    func yearString() -> String {
        let calendar = Calendar.current
        if let date = self.releaseDate {
            return "\(calendar.component(.year, from: date))"
        } else {
            return ""
        }
    }
    
    func genresString() -> String {
        return self.genres.joined(separator: ", ")
    }
}
