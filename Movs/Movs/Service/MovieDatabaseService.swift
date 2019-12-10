//
//  MovieDatabaseService.swift
//  Movs
//
//  Created by Lucca Ferreira on 03/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

enum MovieDatabaseServiceError: Error {
    case url(URLError?)
    case decode
    case unknown(Error)
}

final class MovieDatabaseService {

    static private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        return URLSession(configuration: configuration)
    }()

    static private let key = "922fb0cb0fadf7dfb0e8907b8d508cb2"

    static private let urlComponents: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.queryItems = [URLQueryItem(name: "api_key", value: key)]
        return urlComponents
    }()

    class func popularMovies(fromPage page: Int) -> AnyPublisher<[Movie], MovieDatabaseServiceError> {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/popular"
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        guard let url = urlComponents.url else { fatalError() }
        return request(inUrl: url)
            .map { (wrapper: MovieWrapperDTO) in
                    return wrapper.results
            }
            .map { (moviesDTO) -> [Movie] in
                var movies: [Movie] = []
                for movieDTO in moviesDTO {
                    movies.append(Movie(withMovie: movieDTO))
                }
                return movies
            }
            .eraseToAnyPublisher()
    }

    class func getMovieImage(fromPoster posterPath: String?) -> AnyPublisher<UIImage, Never> {
        var urlComponents = self.urlComponents
        urlComponents.host = "image.tmdb.org"
        urlComponents.path = "/t/p/w500/\(posterPath ?? "")"
        guard let url = urlComponents.url else { fatalError() }
        return self.session.dataTaskPublisher(for: url)
            .map { (data: Data, _: URLResponse) -> UIImage in
                return UIImage(data: data) ?? UIImage(named: "imagePlaceholder")!
            }
            .replaceError(with: UIImage(named: "imagePlaceholder")!)
            .retry(5)
            .eraseToAnyPublisher()
    }

    class func getMovie(withId id: Int) -> AnyPublisher<Movie, MovieDatabaseServiceError> {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/\(id)"
        guard let url = urlComponents.url else { fatalError() }
        return request(inUrl: url)
            .map { (movieDetails: MovieDetailsWrapperDTO) -> Movie in
                return Movie(withMovieDetails: movieDetails)
            }
            .eraseToAnyPublisher()
    }

    class func getGenres() -> AnyPublisher<[Genre], MovieDatabaseServiceError> {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/genre/movie/list"
        guard let url = urlComponents.url else { fatalError() }
        return request(inUrl: url)
            .map { (wrapper: GenreWrapperDTO) in
                return wrapper.genres
            }
            .map { (genresDTO) -> [Genre] in
                var genres: [Genre] = []
                for genreDTO in genresDTO {
                    genres.append(Genre(withGenre: genreDTO))
                }
                return genres
            }
            .eraseToAnyPublisher()
    }

    private class func request<T: Decodable>(inUrl url: URL) -> AnyPublisher<T, MovieDatabaseServiceError> {
        return session.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error -> MovieDatabaseServiceError in
            switch error {
            case is DecodingError:
                return MovieDatabaseServiceError.decode
            case is URLError:
                return MovieDatabaseServiceError.url(error as? URLError)
            default:
                return MovieDatabaseServiceError.unknown(error)
            }
        }
        .retry(5)
        .eraseToAnyPublisher()
    }

}

// ------------------------------------------ WRAPPERS
struct GenreWrapperDTO: Decodable {
    var genres: [GenreDTO]
}

struct GenreDTO: Decodable {
    var id: Int
    var name: String
}

struct MovieWrapperDTO: Decodable {
    var page: Int
    var results: [MovieDTO]
    var totalResults: Int
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }

}

struct MovieDetailsWrapperDTO: Decodable {
    var id: Int
    var overview: String
    var releaseDate: String
    var genres: [GenreDTO]
    var title: String
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case genres
        case title
        case posterPath = "poster_path"
    }
}

struct MovieDTO: Decodable {
    var id: Int
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var title: String
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case title
        case posterPath = "poster_path"
    }

}

// ------------------------------------------ FINAL STRUCTS
struct Genre {
    var id: Int
    var name: String

    init(withGenre genre: GenreDTO) {
        self.id = genre.id
        self.name = genre.name
    }
}

class Movie {

    var id: Int
    var overview: String
    var releaseDate: String
    var genreIds: [Int]
    var title: String
    var posterPath: String?
    @Published var isLiked: Bool = false

    init(withMovie movie: MovieDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genreIds
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = false
    }

    init(withMovieDetails movie: MovieDetailsWrapperDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genres.compactMap { $0.id }
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = false
    }

}
