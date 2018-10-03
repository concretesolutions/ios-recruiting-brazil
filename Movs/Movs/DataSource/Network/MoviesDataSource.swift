//
//  MoviesDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

/**
 The object representing the response of TMDB's popular movies.
 */
class PopularMovieResponse: Decodable {
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

/**
 The basic set of methods that any implementation must comform to.
 */
protocol MoviesDataSource {
    func fetchPopularMovies() -> Single<[Movie]>
}

/**
 The default implementation of MoviesDataSource used in the project.
 */
class MoviesDataSourceImpl: MoviesDataSource {

    func fetchPopularMovies() -> Single<[Movie]> {
        let url: URL! = URL(string: "https://api.themoviedb.org/3/movie/popular")
        return requestData(url: url).map({ (data: Data) -> [Movie] in
            if let movies = self.parseMovies(data) {
                return movies
            }
            return []
        })
    }

    private func parseMovies(_ data: Data) -> [Movie]? {
        do {
            let response = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
            return response.results
        } catch {
            return nil
        }
    }
}
