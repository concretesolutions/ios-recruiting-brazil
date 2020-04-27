//
//  MovieDetail.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 25/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import Foundation
import RxSwift

enum VideoType: String, Codable {
    case trailer = "Trailer"
    case teaser = "Teaser"
    case clip = "Clip"
    case featurette = "Featurette"
    case behindTheScenes = "Behind the Scenes"
    case bloopers = "Bloopers"
}


class MovieDetailsVideoResult: Codable {
    let results: [MovieDetailsVideo]
}

class MovieDetailsVideo: Codable {
    let id: String
    let key: String
    let name: String
    let site: String
    let size: Int
    let type: VideoType
}


class Credits: Codable {
    let id: Int
    let cast: [Cast]
    let crew: [Crew]
}

class Cast: Codable {
    let castId: Int
    let character: String
    let creditId: String
    let gender: Int?
    let id: Int
    let name: String
    let order: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case character
        case gender
        case id
        case name
        case order
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case castId = "cast_id"
    }
}

class Crew: Codable {
    let creditId: String
    let department: String
    let gender: Int?
    let id: Int
    let name: String
    let job: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case department
        case gender
        case id
        case name
        case job
        case profilePath = "profile_path"
        case creditId = "credit_id"
    }
}

class MovieDetails: Codable {
    let id: Int
    let posterPath: String?
    let adult: Bool
    let overview: String
    let releaseDate: String
    let genres: [Genre]
    let originalTitle: String
    let originalLanguage: String
    let title: String
    let backdropPath: String?
    let video: Bool
    let popularity: Double
    let voteCount: Int
    let voteAverage: Double
    
    let imdbId: String?
    let budget: Int
    let revenue: Int
    let runtime: Int?
    let status: String
    let tagline: String?
    
    var videos: [MovieDetailsVideo]?
    var cast: [Cast]?
    var crew: [Crew]?
    
    init(with movie: Movie) {
        self.id = movie.id
        self.posterPath = movie.posterPath
        self.adult = movie.adult
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.originalTitle = movie.originalTitle
        self.originalLanguage = movie.originalLanguage
        self.title = movie.title
        self.backdropPath = movie.backdropPath
        self.video = movie.video
        self.popularity = movie.popularity
        self.voteCount = movie.voteCount
        self.voteAverage = movie.voteAverage
        
//        self.genres = movie.genreIds.enumerated().map({ (idx, id) -> Genre in
//            let genreName = movie.genres![idx]
//            return Genre(id: id, name: genreName)
//        })
        self.genres = []
        self.videos = []
        self.cast = []
        self.crew = []
        
        self.imdbId = ""
        self.budget = 0
        self.revenue = 0
        self.runtime = 0
        self.status = ""
        self.tagline = ""
    }
    
    init(with favorite: Favorite) {
        self.id = favorite.id
        self.posterPath = favorite.posterPath
        self.adult = favorite.adult
        self.overview = favorite.overview
        self.releaseDate = favorite.releaseDate
        self.originalTitle = favorite.originalTitle
        self.originalLanguage = favorite.originalLanguage
        self.title = favorite.title
        self.backdropPath = favorite.backdropPath
        self.video = favorite.video
        self.popularity = favorite.popularity
        self.voteCount = favorite.voteCount
        self.voteAverage = favorite.voteAverage
//
//        self.genres = favorite.genreIds.enumerated().map({ (idx, id) -> Genre in
//            let genreName = favorite.genres![idx]
//            return Genre(id: id, name: genreName)
//        })
//
        self.genres = []
        self.videos = []
        self.cast = []
        self.crew = []

        self.imdbId = ""
        self.budget = 0
        self.revenue = 0
        self.runtime = 0
        self.status = ""
        self.tagline = ""
    }
}

extension MovieDetails {

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case adult
        case video
        case popularity
        case overview
        case genres
        case budget
        case revenue
        case runtime
        case status
        case tagline
        case videos
        case cast
        case crew
        case imdbId = "imdb_id"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

extension MovieDetails {
    
    
//    static func getVideos(of movieId: Int) -> Single<[MovieDetailsVideo]> {
//        let endopoint: Endpoint<MovieDetailsVideoResult> = Endpoint(path: "/movie/\(movieId)/videos")
//        return Single<[MovieDetailsVideo]>.create { observer in
//            Client.shared.request(Endpoint(path: "/movie/\(movieId)/videos"))
//                .subscribe(onSuccess: { data in
//                    observer(.success(data.results))
//                }, onError: { error in
//                    switch error {
//                    case ApiError.conflict:
//                        print("Conflict error")
//                    case ApiError.forbidden:
//                        print("Forbidden error")
//                    case ApiError.notFound:
//                        print("Not found error")
//                    default:
//                        print("Unknown error:", error)
//                    }
//                    observer(.error(error))
//                })
//        }
//    }
//
//    static func getCredits(of movieId: Int) -> Single<Credits> {
//        let endopoint: Endpoint<Credits> = Endpoint(path: "/movie/\(movieId)/credits")
//        return Single<Credits>.create { observer in
//            Client.shared.request(endopoint)
//                .subscribe(onSuccess: { credits in
//                     observer(.success(credits))
//                }, onError: { error in
//                    switch error {
//                    case ApiError.conflict:
//                        print("Conflict error")
//                    case ApiError.forbidden:
//                        print("Forbidden error")
//                    case ApiError.notFound:
//                        print("Not found error")
//                    default:
//                        print("Unknown error:", error)
//                    }
//                    observer(.error(error))
//                })
//        }
//    }
//
//    static func getDetails(of movieId: Int) -> Single<MovieDetail> {
//        let endopoint: Endpoint<MovieDetail> = Endpoint(path: "/movie/\(movieId)")
//        return Single<MovieDetail>.create { observer in
//            Client.shared.request(endopoint)
//                .subscribe(onSuccess: { data in
//                     observer(.success(data))
//                }, onError: { error in
//                    switch error {
//                    case ApiError.conflict:
//                        print("Conflict error")
//                    case ApiError.forbidden:
//                        print("Forbidden error")
//                    case ApiError.notFound:
//                        print("Not found error")
//                    default:
//                        print("Unknown error:", error)
//                    }
//                    observer(.error(error))
//                })
//        }
//    }
    
    static func get(id movieId: Int) -> Single<MovieDetails> {
        
        let videosEndpoint: Endpoint<MovieDetailsVideoResult> = Endpoint(path: "/movie/\(movieId)/videos")
        let creditsEndpoint: Endpoint<Credits> = Endpoint(path: "/movie/\(movieId)/credits")
        let detailsEndpoint: Endpoint<MovieDetails> = Endpoint(path: "/movie/\(movieId)")
        
        return Single<MovieDetails>.create { observer in
            Observable.zip(
                Client.shared.request(videosEndpoint).asObservable(),
                Client.shared.request(creditsEndpoint).asObservable(),
                Client.shared.request(detailsEndpoint).asObservable(),
               resultSelector: { videos, credits, details in
                    details.videos = videos.results
                    details.crew = credits.crew
                    details.cast = credits.cast
                    observer(.success(details))
            }).observeOn(MainScheduler.instance)
            .subscribe()
//            .disposed(by: disposeBag)
        }
    }
}

extension MovieDetailsVideo: Equatable {
    static func == (lhs: MovieDetailsVideo, rhs: MovieDetailsVideo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MovieDetails: Equatable {
    static func == (lhs: MovieDetails, rhs: MovieDetails) -> Bool {
        return lhs.id == rhs.id
            && lhs.imdbId == rhs.imdbId
            && lhs.videos == rhs.videos
            && lhs.genres == rhs.genres
    }
}
