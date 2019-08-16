//
//  Movie.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import UIKit

public struct Movie {

    var id: Int
    var title: String
    var posterPath: String?
    var genres: [Genre]
    var overview: String
    var releaseYear: String
    var isFavorite = false
    var poster: UIImage?

    public init(id: Int,
                title: String,
                posterPath: String,
                overview: String,
                releaseYear: String,
                genres: [Genre]) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
        self.overview = overview
        self.releaseYear = releaseYear
        self.genres = genres
    }

    public init(realmObject: MovieRealm) {
        self.id = realmObject.id
        self.title = realmObject.title
        self.posterPath = realmObject.posterPath
        self.overview = realmObject.overview
        self.releaseYear = realmObject.releaseYear
        self.genres = []
        realmObject.genres.forEach({ self.genres.append(Genre(realmObject: $0)) })
        if let posterImageData = realmObject.poster {
            self.poster = UIImage(data: posterImageData)
        } else {
            self.poster = UIImage(named: "Splash")
        }
    }

    func realm() -> MovieRealm {
        return MovieRealm.build({ movieRealm in
            movieRealm.id = self.id
            movieRealm.title = self.title
            movieRealm.posterPath = self.posterPath ?? ""
            movieRealm.overview = self.overview
            movieRealm.releaseYear = self.releaseYear
            movieRealm.poster = (self.poster ?? UIImage(named: "Splash") ?? UIImage()).jpegData(compressionQuality: 1.0)
            for genre in self.genres {
                movieRealm.genres.append(genre.realm())
            }

        })
    }

}

extension Movie: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case genres = "genre_ids"
        case overview
        case releaseYear = "release_date"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        overview = try container.decode(String.self, forKey: .overview)
        posterPath = try? container.decode(String.self, forKey: .posterPath)

        let releaseDate = try container.decode(String.self, forKey: .releaseYear)
        if !releaseDate.isEmpty {
            releaseYear = String(releaseDate.prefix(4))
        } else {
            releaseYear = "Unknown"
        }

        genres = [Genre]()
        let ids = try container.decode([Int].self, forKey: .genres)
        ids.forEach({ self.genres.append(Genre(id: $0)) })

    }
}
