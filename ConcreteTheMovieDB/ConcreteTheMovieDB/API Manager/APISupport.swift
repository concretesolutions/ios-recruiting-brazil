//
//  APISupport.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 12/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation

struct APISupport {
    static let apiKey = "api_key=24934c88c611524faa7d6c14bed3c866"
    static let baseURL = "https://api.themoviedb.org/3/movie/"
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500/"
}

enum ResourceName: String {
    case nowPlaying = "now_playing?"
}
