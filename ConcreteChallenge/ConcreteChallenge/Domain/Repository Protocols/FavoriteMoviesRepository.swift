//
//  FavoriteMoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

typealias ActionResult<ErrorType: Error> = Result<Void, ErrorType>

protocol FavoriteMoviesRepository: MoviesRepository {
    func addMovieToFavorite(_ movie: Movie, completion: @escaping (ActionResult<Error>) -> Void)
    func removeMovieFromFavorite(movieID: Int, completion: @escaping (ActionResult<Error>) -> Void)
}
