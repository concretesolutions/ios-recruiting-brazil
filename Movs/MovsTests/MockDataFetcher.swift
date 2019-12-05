//
//  MockDataFetcher.swift
//  MovsTests
//
//  Created by Carolina Cruz Agra Lopes on 04/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit
@testable import Movs

class MockDataFetcher {

    // MARK: - Variables

    var genres: [Int: String] = [:]
    var movies: [Int: [PopularMovieDTO]] = [:]
    var smallImages: [String: UIImage] = [:]
    var bigImages: [String: UIImage] = [:]
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

    func requestSmallImage(withPath imagePath: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let image = self.smallImages[imagePath]
        let error: Error? = image == nil ? MoviesDataFetcherError(description: "No image") : nil

        completion(image, error)
    }

    func requestBigImage(withPath imagePath: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let image = self.bigImages[imagePath]
        let error: Error? = image == nil ? MoviesDataFetcherError(description: "No image") : nil

        completion(image, error)
    }
}

// MARK: - Error

struct MoviesDataFetcherError: Error {
    let description: String
}
