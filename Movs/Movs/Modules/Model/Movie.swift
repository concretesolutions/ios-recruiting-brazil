//
//  Movie.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

class Movie {

    // MARK: - Variable

    let id: Int
    let title: String
    let overview: String
    let releaseYear: String
    let posterPath: String?
    let genreIds: [Int]
    var isFavourite: Bool

    // MARK: - Initializers

    init(fromDTO dto: PopularMovieDTO, isFavourite: Bool) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        self.releaseYear = String(dto.releaseDate.split(separator: "-").first!)
        self.posterPath = dto.posterPath
        self.genreIds = dto.genreIds
        self.isFavourite = isFavourite
    }
}

extension Movie: CustomStringConvertible {
    var description: String {
        "Movie{\n" + "\tid: \(self.id)\n" + "\ttitle: \(self.title)\n" + "\toverview: \(self.overview)\n" + "\treleaseYear: \(self.releaseYear)\n" + "\tposterPath: \(self.posterPath)\n" + "\tgenreIds: \(self.genreIds)\n" + "\tisFavourite: \(self.isFavourite)\n" + "}\n"
    }
}
