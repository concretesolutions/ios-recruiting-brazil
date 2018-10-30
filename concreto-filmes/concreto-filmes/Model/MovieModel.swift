//
//  MovieModel.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 24/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import Foundation

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

struct Movie {
    let id: Int
    let posterPath: String?
    let title: String
    let releaseDate: Date?
    let overview: String
    let genreIDS: [Int]
}

extension Movie: Decodable {

    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case overview
        case genreIDS = "genre_ids"
    }

    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)

        id = try movieContainer.decode(Int.self, forKey: .id)
        posterPath = try? movieContainer.decode(String.self, forKey: .posterPath)
        title = try movieContainer.decode(String.self, forKey: .title)
        if let dateString = try? movieContainer.decode(String.self, forKey: .releaseDate) {
            let formatter = DateFormatter.yyyyMMdd
            releaseDate = formatter.date(from: dateString) } else {
            releaseDate = nil
        }
        overview = try movieContainer.decode(String.self, forKey: .overview)
        genreIDS = try movieContainer.decode([Int].self, forKey: .genreIDS)
    }
}
