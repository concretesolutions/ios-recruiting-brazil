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

    private var imageBaseURL: String?

    // MARK: - Poster sizes

    private var smallPosterSize: String!
    private var bigPosterSize: String!

    // MARK: - Dependency handler

    private var imageConfigurationGroup: DispatchGroup?

    // MARK: - Concurrency handler

    private let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    // MARK: - Setup

    func setup(completion: @escaping (_ error: Error?) -> Void) {
        guard self.imageBaseURL == nil else { return }

        self.semaphore.wait()
        self.imageConfigurationGroup = DispatchGroup()
        self.imageConfigurationGroup?.enter()
        self.semaphore.signal()

        let url = self.baseURL + "/configuration" + self.apiKey
        self.requestData(with: url) { (data, error) in
            self.semaphore.wait()

            if let error = error {
                self.imageConfigurationGroup = nil
                self.semaphore.signal()
                completion(error)
            } else if let data = data {
                do {
                    let configuration = try JSONDecoder().decode(ConfigurationWrapperDTO.self, from: data)

                    self.smallPosterSize = self.chooseSmallPosterSize(from: configuration.images.posterSizes)
                    self.bigPosterSize = self.chooseBigPosterSize(from: configuration.images.posterSizes)
                    self.imageBaseURL = configuration.images.baseURL

                    self.imageConfigurationGroup?.leave()
                    self.imageConfigurationGroup = nil
                    self.semaphore.signal()
                    completion(nil)
                } catch {
                    self.imageConfigurationGroup = nil
                    self.semaphore.signal()
                    completion(error)
                }
            }
        }
    }

    // MARK: - Image configuration

    private func chooseSmallPosterSize(from sizes: [String]) -> String {
        let chosenSize: String

        if sizes.contains("w185") {
            chosenSize = "w185"
        } else {
            chosenSize = self.chooseSmallPosterSize(from: sizes)
        }

        return chosenSize
    }

    private func chooseBigPosterSize(from sizes: [String]) -> String {
        let chosenSize: String

        if sizes.contains("w300") {
            chosenSize = "w300"
        } else if sizes.contains("w342") {
            chosenSize = "w342"
        } else if sizes.contains("w500") {
            chosenSize = "w500"
        } else {
            chosenSize = "original"
        }

        return chosenSize
    }

    // MARK: - Request methods

    private func requestData(with url: String, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, error) in
            completion(data, error)
        }

        dataTask.resume()
    }

    private func requestImage(withPath imagePath: String, andSize posterSize: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url = self.imageBaseURL! + "/" + posterSize + imagePath
        self.requestData(with: url) { (data, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                completion(UIImage(data: data)!, nil)
            }
        }
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

    func requestSmallImage(withPath imagePath: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        self.semaphore.wait()
        // If the configuration is over
        if self.imageConfigurationGroup == nil {
            // && the small image size has not been chosen
            if self.smallPosterSize == nil {
                completion(nil, MovieAPIError(description: "The image could not be fetched because there has been an error with the image configuration request"))
                self.semaphore.signal()
                return
            } else {
                self.requestImage(withPath: imagePath, andSize: self.smallPosterSize, completion: completion)
            }
        } else {
            self.imageConfigurationGroup?.notify(queue: DispatchQueue.global()) {
                self.requestImage(withPath: imagePath, andSize: self.smallPosterSize, completion: completion)
            }
        }
        self.semaphore.signal()
    }

    func requestBigImage(withPath imagePath: String, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        self.semaphore.wait()
        // If the configuration is over
        if self.imageConfigurationGroup == nil {
            // If the big image size has not been chosen
            if self.smallPosterSize == nil {
                self.semaphore.signal()
                completion(nil, MovieAPIError(description: "The image could not be fetched because there has been an error with the image configuration request"))
                return
            } else {
                self.requestImage(withPath: imagePath, andSize: self.bigPosterSize, completion: completion)
            }
        } else {
            self.imageConfigurationGroup?.notify(queue: DispatchQueue.global()) {
                self.requestImage(withPath: imagePath, andSize: self.bigPosterSize, completion: completion)
            }
        }
        self.semaphore.signal()
    }
}

// MARK: - Error

struct MovieAPIError: Error {
    let description: String
}
