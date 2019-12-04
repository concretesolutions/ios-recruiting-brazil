//
//  PopularMovieDTO.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

struct PopularMoviesWrapperDTO: Decodable {
    let results: [PopularMovieDTO]
}

struct PopularMovieDTO: Decodable {
    let id: Int
    let title: String
    let overview: String
    let genreIds: [Int]
    let releaseDate: String
    let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case id, title, overview, genreIds = "genre_ids", releaseDate = "release_date", posterPath = "poster_path"
    }
}
