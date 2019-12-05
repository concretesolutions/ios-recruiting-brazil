//
//  DataProvider.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 03/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import Foundation
import UIKit

class DataProvider {

    // MARK: - Data fetcher

    private let moviesDataFetcher: MoviesDataFetcherProtocol

    // MARK: - Data variables

    var movies: [Movie] = []
    private var genres: [Int: String] = [:]

    // MARK: - Caches

    // TODO: Add caches

    // MARK: - Control variables

    private var page: Int = 1
    private var isFetchingMovies: Bool = false

    // MARK: - Dependency handler

    private var genresGroup: DispatchGroup?

    // MARK: - Concurrency handler

    private let genreSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    private let movieSemaphore: DispatchSemaphore = DispatchSemaphore(value: 1)

    // MARK: - Initializers

    init(moviesDataFetcher: MoviesDataFetcherProtocol) {
        self.moviesDataFetcher = moviesDataFetcher
    }

    // MARK: - Setup

    func setup(completion: @escaping (_ error: Error?) -> Void) {
        // General setup
        self.moviesDataFetcher.setup { error in
            if let error = error {
                print(error)
            }
        }

        // Genres setup
        self.genreSemaphore.wait()
        self.genresGroup = DispatchGroup()
        self.genresGroup?.enter()
        self.genreSemaphore.signal()
        self.moviesDataFetcher.requestGenres { (genres, error) in
            self.genreSemaphore.wait()
            if let error = error {
                print(error)
            } else {
                self.genres = genres
                self.genresGroup?.leave()
            }

            self.genresGroup = nil
            self.genreSemaphore.signal()
        }

        // Movies setup
        self.getMoreMovies(completion: completion)
    }

    // MARK: - Get methods

    func genre(forId id: Int, completion: @escaping (String?) -> Void) {
        self.genreSemaphore.wait()
        if self.genres == [:] && self.genresGroup != nil {
            self.genresGroup?.notify(queue: DispatchQueue.global()) {
                self.genreSemaphore.signal()
                completion(self.genres[id])
            }
        } else {
            self.genreSemaphore.signal()
            completion(self.genres[id])
        }
    }

    func getMoreMovies(completion: @escaping (_ error: Error?) -> Void) {
        self.movieSemaphore.wait()
        guard self.isFetchingMovies == false else {
            self.movieSemaphore.signal()
            return
        }

        self.isFetchingMovies = true
        self.movieSemaphore.signal()

        self.moviesDataFetcher.requestPopularMovies(fromPage: self.page) { (moviesDTO, error) in
            if let error = error {
                self.movieSemaphore.wait()
                self.isFetchingMovies = false
                self.movieSemaphore.signal()
                completion(error)
            } else {
                let movies = moviesDTO.map { Movie(fromDTO: $0, isFavourite: false) }
                self.movies += movies
                self.page += 1

                self.movieSemaphore.wait()
                self.isFetchingMovies = false
                self.movieSemaphore.signal()
                completion(nil)
            }
        }
    }

    func getSmallImage(forIndex index: Int, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        guard index >= 0 && index < self.movies.count else {
            completion(nil, DataProviderError(description: "Index out of range"))
            return
        }

        guard let path = self.movies[index].posterPath else {
            completion(nil, DataProviderError(description: "The movie has no image"))
            return
        }

        // TODO: check cache

        self.moviesDataFetcher.requestSmallImage(withPath: path) { (image, error) in
            completion(image, error)
        }
    }

    func getBigImage(forIndex index: Int, completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        guard index > 0 && index < self.movies.count else {
            completion(nil, DataProviderError(description: "Index out of range"))
            return
        }

        guard let path = self.movies[index].posterPath else {
            completion(nil, DataProviderError(description: "The movie has no image"))
            return
        }

        // TODO: check cache

        self.moviesDataFetcher.requestBigImage(withPath: path) { (image, error) in
            completion(image, error)
        }
    }
}

struct DataProviderError: Error {
    let description: String
}
