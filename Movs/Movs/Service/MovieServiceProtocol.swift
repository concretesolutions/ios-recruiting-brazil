//
//  MovieServiceProtocol.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

enum APIError: String {
    case requestFailed = "An error has occurred, please try again."
}

protocol MovieServiceProtocol {
    static var shared: MovieServiceProtocol { get }
    var popularMovies: [Movie] { get }
    func fetchPopularMovies(completition: @escaping MoviesListCompletionBlock)
    func fectchFavoriteMovies(completition: @escaping MoviesListCompletionBlock)
}
