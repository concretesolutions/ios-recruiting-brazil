//
//  SearchMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol SearchMoviesRepository {
    func getMovies(query: String, fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void)
}
