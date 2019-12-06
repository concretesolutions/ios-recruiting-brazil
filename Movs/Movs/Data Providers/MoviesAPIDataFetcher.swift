//
//  MoviesAPIDataFetcher.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 02/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

final class MoviesAPIDataFetcher {

    // MARK: - Constants

    private let baseURL = "https://api.themoviedb.org/3"
    private let apiKey = "?api_key=cd452742413393c82b42c10e1c1cb8c7"

    // MARK: - Variables

    private let imageBaseURL = "https://image.tmdb.org/t/p/"
    private let smallImageSize = "w185"
    private let bigImageSize = "w300"

    // MARK: - Request methods

    private func requestData(with url: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, error) in
            completion(data, error)
        }

        dataTask.resume()
    }
}

extension MoviesAPIDataFetcher: MoviesDataFetcherProtocol {

    // MARK: - Data request methods

    func requestGenres(completion: @escaping (_ genres: [Int: String], _ error: Error?) -> Void) {
        let url = baseURL + "/genre/movie/list" + apiKey
        self.requestData(with: url) { (data, error) in
            if let error = error {
                completion([:], error)
            } else if let data = data {
                do {
                    let genreData = try JSONDecoder().decode(GenreWrapperDTO.self, from: data)

                    var genres: [Int: String] = [:]
                    for genre in genreData.genres {
                        genres[genre.id] = genre.name
                    }

                    completion(genres, nil)
                } catch {
                    completion([:], error)
                }
            }
        }
    }

    func requestPopularMovies(fromPage page: Int, completion: @escaping (_ movies: [PopularMovieDTO], _ error: Error?) -> Void) {
        let url = self.baseURL + "/movie/popular" + self.apiKey + "&page=\(page)"
        self.requestData(with: url) { (data, error) in
            if let error = error {
                completion([], error)
            } else if let data = data {
                do {
                    let popularMovies = try JSONDecoder().decode(PopularMoviesWrapperDTO.self, from: data)
                    completion(popularMovies.results, nil)
                } catch {
                    completion([], error)
                }
            }
        }
    }

    func smallImageURL(forPath imagePath: String) -> String {
        return self.imageBaseURL + self.smallImageSize + imagePath
    }

    func bigImageURL(forPath imagePath: String) -> String {
        return self.imageBaseURL + self.bigImageSize + imagePath
    }
}
