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

    var genres: [GenreDTO] = []
    var movies: [Int: [PopularMovieDTO]] = [:]
    var movieDetails: [Int: MovieDTO] = [:]
    var smallImages: [String: String] = [:]
    var bigImages: [String: String] = [:]

    // MARK: - Data mocking

    func mockData() {
        self.mockGenres()
        self.mockMovies()
    }

    func mockGenres() {
        self.genres = [
            GenreDTO(id: 1, name: "Action"),
            GenreDTO(id: 2, name: "Romance"),
            GenreDTO(id: 3, name: "Adventure"),
            GenreDTO(id: 4, name: "Comedy"),
            GenreDTO(id: 5, name: "Drama")
        ]
    }

    func mockMovies() {
        self.movies[1] = [
            PopularMovieDTO(id: 1, title: "Movie_1", overview: "Movie_1 overview", popularity: 100.0, genreIds: [1], releaseDate: "2019", posterPath: "/Movie_1.jpg"),
            PopularMovieDTO(id: 2, title: "Movie_2", overview: "Movie_2 overview", popularity: 90.0, genreIds: [4], releaseDate: "2010", posterPath: "/Movie_2.jpg")
        ]
        self.movies[2] = [
            PopularMovieDTO(id: 3, title: "Movie_3", overview: "Movie_3 overview", popularity: 80.0, genreIds: [2, 4], releaseDate: "3000", posterPath: nil)
        ]

        self.movieDetails[4] = MovieDTO(id: 4, title: "Movie_4", overview: "Movie_4 overview", popularity: 30.0, genres: [GenreDTO(id: 5, name: "Drama")], releaseDate: "1997", posterPath: nil)
    }
}

extension MockDataFetcher: MoviesDataFetcherProtocol {

    // MARK: - Data request methods

    func requestGenres(completion: @escaping ([GenreDTO], Error?) -> Void) {
        let error: Error? = self.genres == [] ? MoviesDataFetcherError(description: "No genre") : nil

        completion(self.genres, error)
    }

    func requestPopularMovies(fromPage page: Int, completion: @escaping ([PopularMovieDTO], Error?) -> Void) {
        let movies = self.movies[page]
        let error: Error? = (movies == nil) ? MoviesDataFetcherError(description: "No movies for page \(page)") : nil

        completion(movies ?? [], error)
    }

    func requestMovieDetails(forId id: Int, completion: @escaping (_ movie: MovieDTO?, _ error: Error?) -> Void) {
        let movie = self.movieDetails[id]
        let error: Error? = (movie == nil) ? MoviesDataFetcherError(description: "No movie for id \(id)") : nil

        completion(movie, error)
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
