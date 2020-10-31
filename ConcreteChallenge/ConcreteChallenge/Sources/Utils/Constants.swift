//
//  Constants.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum Constants {
    struct Utils {
        static let dateFormat = "yyyy-MM-dd"
    }

    // MARK: - Newtwork

    struct MovieNetwork {
        static let baseURL = "https://api.themoviedb.org"
        static let apiVersion = "3"
        static let baseImageURL = "https://image.tmdb.org/t/p/w500"

        // MARK: - Paths

        static let genres = "/genre/movie/list"
        static let moviePopular = "/movie/popular"

        // MARK: - Parameters

        static let apiKey = "api_key"
        static let apiKeyValue = "9b9f207b503e03a4e0b1267156c23dd2"
        static let language = "language"
        static let page = "page"

        // MARK: - Headers

        static let headersContentTypeApplicationJSON = ["Content-Type": "application/json"]
    }

    // MARK: - Default parameters

    struct MovieDefaultParameters {
        static let language = "en-US"
        static let page = 1
    }

    // MARK: - Database

    struct MovieDatabase {
        static let moviePrimaryKey = "id"
    }

    // MARK: - Screen configuration

    struct GridGalleryCollectionView {
        static let amountItemVertical = 4.5
        static let amountItemHorizontal = 2
        static let verticalMargin = 16
        static let horizontalMargin = 16
        static let minimumLineSpacing = 16
    }

    struct MoviesDetails {
        static let genresSeparator = ", "
    }
}
