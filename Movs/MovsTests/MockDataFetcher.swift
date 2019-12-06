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
