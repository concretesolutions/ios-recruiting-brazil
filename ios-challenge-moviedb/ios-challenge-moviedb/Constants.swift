//
//  Constans.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 21/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

struct Constants {
    // MARK: - Network Constants
    struct ProductionServer {
        static let base = "https://api.themoviedb.org/3/"
        static let image = "https://image.tmdb.org/t/p/"
    }
    struct APIParameterKey {
        static let apiKey = "ffc4ed77b7cb17c2465a2c2e9bb593b8"
    }
}

// MARK: - Header Field
enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

// MARK: - JSON Path
enum ContentType: String {
    case json = "application/json"
}
