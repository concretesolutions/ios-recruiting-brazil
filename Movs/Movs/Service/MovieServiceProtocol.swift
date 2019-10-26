//
//  MovieServiceProtocol.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

enum APIError: String, Error {
    case requestFailed = "An error has occurred, please try again."
}

protocol MovieServiceProtocol {
    func fectchPopularMovies(completed: @escaping (_ success: Bool, _ error: APIError?, _ movies: [Movie]) -> ())
}
