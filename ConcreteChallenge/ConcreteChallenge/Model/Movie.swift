//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 18/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import RxSwift

class MovieResponse: Codable {
    let page: Int
    let results: [Movie]
}

class Movie: Codable {
    let id: Int
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genreIds: [Int]
    var genres: [String]?
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let video: Bool
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    
    var favorited: Bool = false
    
    init(
        id: Int,
        posterPath: String?,
        adult: Bool,
        overview: String,
        releaseDate: String,
        genreIds: [Int],
        genres: [String]?,
        originalTitle: String,
        originalLanguage: String,
        title: String,
        backdropPath: String?,
        video: Bool,
        popularity: Double,
        voteCount: Int,
        voteAverage: Double,
        favorited: Bool
    ) {
        self.id = id
        self.posterPath = posterPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
        self.genreIds = genreIds
        self.genres = genres
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.title = title
        self.backdropPath = backdropPath
        self.video = video
        self.popularity = popularity
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.favorited = favorited
    }
    
    func toggleFavorite() {
        if favorited {
            mainStore.dispatch(FavoriteThunk.remove(id: id))
        } else {
            let favorite = Favorite(with: self)
            mainStore.dispatch(FavoriteThunk.insert(favorite))
        }
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case adult
        case video
        case popularity
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
                && lhs.favorited == rhs.favorited
                && lhs.genres == rhs.genres
    }
    
    func clone() throws -> Movie {
        let jsonData = try JSONEncoder().encode(self)
        return try JSONDecoder().decode(Movie.self, from: jsonData)
    }
}



extension Movie {
    static func popular(page: Int) -> Single<[Movie]> {
        let endopoint: Endpoint<MovieResponse> = Endpoint(path: "/movie/popular")
        return Single<[Movie]>.create { observer in
            Client.shared.request(endopoint)
                .subscribe(onSuccess: { data in
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
//                        observer(.success(data.results))
//                    }
                     observer(.success(data.results))
                }, onError: { error in
                    switch error {
                    case ApiError.conflict:
                        print("Conflict error")
                    case ApiError.forbidden:
                        print("Forbidden error")
                    case ApiError.notFound:
                        print("Not found error")
                    default:
                        print("Unknown error:", error)
                    }
                    observer(.error(error))
                })
        }
    }
}
