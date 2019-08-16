//
//  MovieService.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 15/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation

public protocol MovieService {

    func getPopularMovies(page: Int, completion: @escaping (Result<[Movie]>) -> Void)
    func getGenres(completion: @escaping (Result<[Genre]>) -> Void)
}
