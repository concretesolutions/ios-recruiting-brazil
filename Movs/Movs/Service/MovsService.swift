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

final class MovsService {
    
    enum MovsServiceError: Error {
        case url(URLError?)
        case decode
        case unknown(Error)
    }

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

    class func popularMovies(fromPage page: Int) -> AnyPublisher<[Movie], MovsServiceError> {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/popular"
        urlComponents.queryItems?.append(URLQueryItem(name: "page", value: String(page)))
        guard let url = urlComponents.url else { fatalError() }
        return request(inUrl: url)
            .map { (wrapper: PopularMoviesWrapperDTO) in
                    return wrapper.results
            }
            .map { (moviesDTO) -> [Movie] in
                return moviesDTO.compactMap { (movieDTO) -> Movie? in
                    return Movie(withMovie: movieDTO)
                }
            }
            .eraseToAnyPublisher()
    }

    class func getMoviePoster(fromPath path: String?) -> AnyPublisher<UIImage, Never> {
        var urlComponents = self.urlComponents
        urlComponents.host = "image.tmdb.org"
        urlComponents.path = "/t/p/w500/\(path ?? "")"
        guard let url = urlComponents.url else { fatalError() }
        return self.session.dataTaskPublisher(for: url)
            .map { (data: Data, _: URLResponse) -> UIImage in
                return UIImage(data: data) ?? UIImage(named: "imagePlaceholder")!
            }
            .replaceError(with: UIImage(named: "imagePlaceholder")!)
            .retry(5)
            .eraseToAnyPublisher()
    }

    class func getMovie(withId id: Int) -> AnyPublisher<Movie, MovsServiceError> {
        var urlComponents = self.urlComponents
        urlComponents.path = "/3/movie/\(id)"
        guard let url = urlComponents.url else { fatalError() }
        return request(inUrl: url)
            .map { (movieDetails: MovieWrapperDTO) -> Movie in
                return Movie(withMovieDetails: movieDetails)
            }
            .retry(5)
            .eraseToAnyPublisher()
    }

    class func getGenres() -> AnyPublisher<[Genre], MovsServiceError> {
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

    private class func request<T: Decodable>(inUrl url: URL) -> AnyPublisher<T, MovsServiceError> {
        return session.dataTaskPublisher(for: url)
        .map { $0.data }
        .decode(type: T.self, decoder: JSONDecoder())
        .mapError { error -> MovsServiceError in
            switch error {
            case is DecodingError:
                return MovsServiceError.decode
            case is URLError:
                return MovsServiceError.url(error as? URLError)
            default:
                return MovsServiceError.unknown(error)
            }
        }
        .retry(5)
        .eraseToAnyPublisher()
    }

}

