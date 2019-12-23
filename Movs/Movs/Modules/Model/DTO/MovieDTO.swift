//
//  MovieDTO.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 23/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

struct MovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let genres: [GenreDTO]
    let releaseDate: String?
    let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genres, releaseDate = "release_date", posterPath = "poster_path"
    }
}

extension MovieDTO: Equatable {
    static func == (lhs: MovieDTO, rhs: MovieDTO) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.overview == rhs.overview && lhs.releaseDate == rhs.releaseDate && lhs.posterPath == rhs.posterPath && lhs.genres == rhs.genres
    }
}
