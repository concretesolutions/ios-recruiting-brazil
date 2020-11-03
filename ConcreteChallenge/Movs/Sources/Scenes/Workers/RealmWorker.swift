//
//  MoviesRealmWorker.swift
//  Movs
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

protocol RealmWorkerProtocol: AnyObject {
    func fetchMovies(completion: @escaping (Result<[Movie], DatabaseError>) -> Void)
    func saveMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void)
    func deleteMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void)
}

final class RealmWorker: RealmWorkerProtocol {
    private let provider: MovieRealmDbService

    // MARK: - Initializers

    init(provider: MovieRealmDbService) {
        self.provider = provider
    }

    // MARK: - MovieDetailsWorkerProtocol conforms

    func fetchMovies(completion: @escaping (Result<[Movie], DatabaseError>) -> Void) {
        provider.fetch(Movie.self, completion: completion)
    }

    func saveMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        provider.save(model: movie, completion: completion)
    }

    func deleteMovie(movie: Movie, completion: @escaping (Result<Void, DatabaseError>) -> Void) {
        provider.delete(model: movie, completion: completion)
    }
}
