//
//  MovieDetailsWorkerProtocol.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol MovieDetailsWorkerProtocol: AnyObject {
    func fetchMovies(completion: @escaping (Result<[Movie], DatabaseError>) -> Void)
    func saveMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void)
    func deleteMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void)
}
