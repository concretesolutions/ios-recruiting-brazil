//
//  MoviesRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

protocol MoviesRepository {
    func getMovies(fromPage page: Int, completion: @escaping (Result<Page<Movie>, Error>) -> Void)
}

//protocol EditableMoviesRepository {
//    func addMovie(movie: Movie, completion: @escaping (ActionResult<Error>) -> Void)
//}
