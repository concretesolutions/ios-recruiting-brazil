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
    var favoriteMovies: [Movie] = []
    private(set) var genres: [Int: Genre] = [:]

    // MARK: - Closures

    var didChangeFavorites: () -> Void = { }

    // MARK: - Caches

    // TODO: Add caches

    // MARK: - Control variables

    private var page: Int = 1
    private var isFetchingMovies: Bool = false

    // MARK: - Concurrency handler

    private var movieSemaphore: DispatchSemaphore? = DispatchSemaphore(value: 1)

    // MARK: - Initializers

    private init() { }

    // MARK: - Reset

    func reset() {
        self.moviesDataFetcher = nil
        self.movies = []
        self.favoriteMovies = []
        self.genres = [:]
        self.page = 1
        self.isFetchingMovies = false
        self.movieSemaphore = nil
    }

    // MARK: - Setup

    func setup(withDataFetcher moviesDataFetcher: MoviesDataFetcherProtocol = MoviesAPIDataFetcher(), completion: @escaping (_ error: Error?) -> Void) {
        self.moviesDataFetcher = moviesDataFetcher

        // Genres setup
        let group = DispatchGroup()
        group.enter()
        self.moviesDataFetcher.requestGenres { (genresDTO, error) in
            if let error = error {
                print(error)
            } else {
                for genreDTO in genresDTO {
                    self.genres[genreDTO.id] = Genre(fromDTO: genreDTO)
                }
                group.leave()
            }
        }
        group.wait()

        // Movies setup
        self.getMoreMovies(completion: completion)
    }

    // MARK: - Get methods

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
                let favoriteIDs: [Int] = UserDefaults.standard.object(forKey: "favoriteIDs") as? [Int] ?? []

                let movies = moviesDTO.map { movieDTO -> Movie in
                    let movie: Movie
                    if let posterPath = movieDTO.posterPath {
                        movie = Movie(fromDTO: movieDTO, smallImageURL: self.moviesDataFetcher.smallImageURL(forPath: posterPath), bigImageURL: self.moviesDataFetcher.bigImageURL(forPath: posterPath), isFavorite: false)
                    } else {
                        movie = Movie(fromDTO: movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: false)
                    }

                    if favoriteIDs.contains(movie.id) {
                        movie.isFavorite = true
                        self.favoriteMovies.append(movie)
                    } else {
                        movie.isFavorite = false
                    }

                    return movie
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

    func getFavoriteMovie(withId id: Int, completion: @escaping (_ error: Error?) -> Void) {
        guard self.moviesDataFetcher != nil else {
            completion(DataProviderError(desciption: "Tried to get a movie without a dataFetcher"))
            return
        }

        self.moviesDataFetcher.requestMovieDetails(forId: id) { (movieDTO, error) in
            if let error = error {
                completion(error)
            } else if let movieDTO = movieDTO {
                let movie: Movie
                if let posterPath = movieDTO.posterPath {
                    movie = Movie(fromDTO: movieDTO, smallImageURL: self.moviesDataFetcher.smallImageURL(forPath: posterPath), bigImageURL: self.moviesDataFetcher.bigImageURL(forPath: posterPath), isFavorite: true)
                } else {
                    movie = Movie(fromDTO: movieDTO, smallImageURL: nil, bigImageURL: nil, isFavorite: true)
                }

                self.favoriteMovies.append(movie)

                completion(nil)
            }
        }
    }

    // MARK: - Favorite movies

    func addFavoriteMovie(_ movie: Movie) {
        guard var favoriteIDs = UserDefaults.standard.object(forKey: "favoriteIDs") as? [Int] else {
            UserDefaults.standard.set([movie.id], forKey: "favoriteIDs")
            self.favoriteMovies.append(movie)
            self.didChangeFavorites()
            return
        }

        if !favoriteIDs.contains(movie.id) {
            favoriteIDs.append(movie.id)
            UserDefaults.standard.set(favoriteIDs, forKey: "favoriteIDs")
            self.favoriteMovies.append(movie)
            self.didChangeFavorites()
        }
    }

    func removeFavoriteMovie(_ movie: Movie) {
        guard var favoriteIDs = UserDefaults.standard.object(forKey: "favoriteIDs") as? [Int] else {
            return
        }

        favoriteIDs.removeAll(where: { $0 == movie.id })
        UserDefaults.standard.set(favoriteIDs, forKey: "favoriteIDs")
        self.favoriteMovies.removeAll(where: { $0 == movie })
        self.didChangeFavorites()
    }
}

struct DataProviderError: Error {
    let desciption: String
}
