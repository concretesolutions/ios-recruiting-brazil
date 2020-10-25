//
//  Constants.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

enum Constants {
    struct MovieNetwork {
        static let baseURL = "https://api.themoviedb.org"
        static let apiVersion = "3"

        // MARK: - Paths

        static let moviePopular = "/movie/popular"

        // MARK: - Parameters

        static let apiKey = "api_key"
        static let apiKeyValue = "9b9f207b503e03a4e0b1267156c23dd2"

        // MARK: - Headers

        static let headersContentTypeApplicationJSON = ["Content-Type": "application/json"]
    }
}
