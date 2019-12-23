//
//  Movie.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

class Movie {

    // MARK: - Variables

    let id: Int
    let title: String
    let overview: String
    let releaseYear: String
    let posterPath: String?
    var genres: [Genre]
    let smallImageURL: String?
    let bigImageURL: String?
    var isFavorite: Bool {
        didSet {
            if self.isFavorite {
                DataProvider.shared.addFavoriteMovie(self)
            } else {
                DataProvider.shared.removeFavoriteMovie(self)
            }
            self.didSetIsFavorite()
        }
    }

    // MARK: - Closures

    var didSetIsFavorite: () -> Void = { }

    // MARK: - Initializers

    init(fromDTO dto: PopularMovieDTO, smallImageURL: String?, bigImageURL: String?, isFavorite: Bool) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        if let releaseDate = dto.releaseDate, let year = releaseDate.split(separator: "-").first {
            self.releaseYear = String(year)
        } else {
            self.releaseYear = "----"
        }
        self.posterPath = dto.posterPath
        self.genres = dto.genreIds.map { DataProvider.shared.genres[$0]! }
        self.smallImageURL = smallImageURL
        self.bigImageURL = bigImageURL
        self.isFavorite = isFavorite
    }

    init(fromDTO dto: MovieDTO, smallImageURL: String?, bigImageURL: String?, isFavorite: Bool) {
        self.id = dto.id
        self.title = dto.title
        self.overview = dto.overview
        if let releaseDate = dto.releaseDate, let year = releaseDate.split(separator: "-").first {
            self.releaseYear = String(year)
        } else {
            self.releaseYear = "----"
        }
        self.posterPath = dto.posterPath
        self.genres = dto.genres.map { Genre(fromDTO: $0) }
        self.smallImageURL = smallImageURL
        self.bigImageURL = bigImageURL
        self.isFavorite = isFavorite
    }
}

extension Movie: CustomStringConvertible {
    var description: String {
        "Movie {\n" + "\tid: \(self.id)\n" + "\ttitle: \(self.title)\n" + "\toverview: \(self.overview)\n" + "\treleaseYear: \(self.releaseYear)\n" + "\tposterPath: \(String(describing: self.posterPath))\n" + "\tgenres: \(self.genres)\n" + "\tsmallImageURL: \(String(describing: self.smallImageURL))\n" + "\tbigImageURL:: \(String(describing: self.bigImageURL))\n" + "\tisFavorite: \(self.isFavorite)\n" + "}\n"
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id && lhs.title == rhs.title && lhs.overview == rhs.overview && lhs.releaseYear == rhs.releaseYear && lhs.posterPath == rhs.posterPath && lhs.genres == rhs.genres && lhs.smallImageURL == rhs.smallImageURL && lhs.bigImageURL == rhs.bigImageURL && lhs.isFavorite == rhs.isFavorite
    }
}
