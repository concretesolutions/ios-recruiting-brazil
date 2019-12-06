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

    // MARK: - Singleton

    static var shared = DataProvider()

    // MARK: - Data fetcher

    private var moviesDataFetcher: MoviesDataFetcherProtocol!

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

    private var genreSemaphore: DispatchSemaphore? = DispatchSemaphore(value: 1)
    private var movieSemaphore: DispatchSemaphore? = DispatchSemaphore(value: 1)

    // MARK: - Initializers

    private init() { }

    // MARK: - Reset

    func reset() {
        self.moviesDataFetcher = nil
        self.movies = []
        self.genres = [:]
        self.page = 1
        self.isFetchingMovies = false
        self.genresGroup = nil
        self.genreSemaphore = nil
        self.movieSemaphore = nil
    }

    // MARK: - Setup

    func setup(withDataFetcher moviesDataFetcher: MoviesDataFetcherProtocol, completion: @escaping (_ error: Error?) -> Void) {
        self.moviesDataFetcher = moviesDataFetcher

        // Genres setup
        self.genreSemaphore?.wait()
        self.genresGroup = DispatchGroup()
        self.genresGroup?.enter()
        self.genreSemaphore?.signal()
        self.moviesDataFetcher.requestGenres { (genres, error) in
            self.genreSemaphore?.wait()
            if let error = error {
                print(error)
            } else {
                self.genres = genres
                self.genresGroup?.leave()
            }

            self.genresGroup = nil
            self.genreSemaphore?.signal()
        }

        // Movies setup
        self.getMoreMovies(completion: completion)
    }

    // MARK: - Get methods

    func genre(forId id: Int, completion: @escaping (String?) -> Void) {
        self.genreSemaphore?.wait()
        if self.genres == [:] && self.genresGroup != nil {
            self.genresGroup?.notify(queue: DispatchQueue.global()) {
                self.genreSemaphore?.signal()
                completion(self.genres[id])
            }
        } else {
            self.genreSemaphore?.signal()
            completion(self.genres[id])
        }
    }

    func getMoreMovies(completion: @escaping (_ error: Error?) -> Void) {
        guard self.moviesDataFetcher != nil else {
            completion(DataProviderError(desciption: "Tried to get more movies without a dataFetcher"))
            return
        }

        self.movieSemaphore?.wait()
        guard self.isFetchingMovies == false else {
            self.movieSemaphore?.signal()
            return
        }

        self.isFetchingMovies = true
        self.movieSemaphore?.signal()

        self.moviesDataFetcher.requestPopularMovies(fromPage: self.page) { (moviesDTO, error) in
            if let error = error {
                self.movieSemaphore?.wait()
                self.isFetchingMovies = false
                self.movieSemaphore?.signal()
                completion(error)
            } else {
                let movies = moviesDTO.map { movieDTO -> Movie in
                    if let posterPath = movieDTO.posterPath {
                        return Movie(fromDTO: movieDTO, smallImageURL: self.moviesDataFetcher.smallImageURL(forPath: posterPath), bigImageURL: self.moviesDataFetcher.bigImageURL(forPath: posterPath), isFavourite: false)
                    } else {
                        return Movie(fromDTO: movieDTO, smallImageURL: nil, bigImageURL: nil, isFavourite: false)
                    }
                }

                self.movies += movies
                self.page += 1

                self.movieSemaphore?.wait()
                self.isFetchingMovies = false
                self.movieSemaphore?.signal()
                completion(nil)
            }
        }
    }
}

struct DataProviderError: Error {
    let desciption: String
}
