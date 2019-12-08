//
//  MockDataFetcher.swift
//  MovsTests
//
//  Created by Carolina Cruz Agra Lopes on 04/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

@testable import Movs

class MockDataFetcher {

    // MARK: - Variables

    var genres: [Int: String] = [:]
    var movies: [Int: [PopularMovieDTO]] = [:]
    var smallImages: [String: String] = [:]
    var bigImages: [String: String] = [:]

    // MARK: - Data mocking

    func mockData() {
        self.mockGenres()
        self.mockMovies()
    }

    func mockGenres() {
        self.genres = [
            1: "Action",
            2: "Romance",
            3: "Adventure",
            4: "Comedy",
            5: "Drama"
        ]
    }

    func mockMovies() {
        self.movies[1] = [
            PopularMovieDTO(id: 1, title: "Movie_1", overview: "Movie_1 overview", genreIds: [1], releaseDate: "2019", posterPath: "/Movie_1.jpg"),
            PopularMovieDTO(id: 2, title: "Movie_2", overview: "Movie_2 overview", genreIds: [4], releaseDate: "2010", posterPath: "/Movie_2.jpg")
        ]
        self.movies[2] = [
            PopularMovieDTO(id: 3, title: "Movie_3", overview: "Movie_3 overview", genreIds: [2, 4], releaseDate: "3000", posterPath: nil)
        ]
    }
}

extension MockDataFetcher: MoviesDataFetcherProtocol {

    // MARK: - Data request methods

    func requestGenres(completion: @escaping ([Int: String], Error?) -> Void) {
        let error: Error? = self.genres == [:] ? MoviesDataFetcherError(description: "No genre") : nil

        completion(self.genres, error)
    }

    func requestPopularMovies(fromPage page: Int, completion: @escaping ([PopularMovieDTO], Error?) -> Void) {
        let movies = self.movies[page]
        let error: Error? = (movies == nil) ? MoviesDataFetcherError(description: "No movies for page \(page)") : nil

        completion(movies ?? [], error)
    }

    func smallImageURL(forPath imagePath: String) -> String {
        return self.smallImages[imagePath] ?? ""
    }

    func bigImageURL(forPath imagePath: String) -> String {
        return self.bigImages[imagePath] ?? ""
    }
}

// MARK: - Error

struct MoviesDataFetcherError: Error {
    let description: String
}
