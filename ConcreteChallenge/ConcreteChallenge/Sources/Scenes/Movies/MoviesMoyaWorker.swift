//
//  MoviesWorker.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class MoviesMoyaWorker: MoviesMoyaWorkerProtocol {
    private let provider: MoyaProvider<MovieDBAPI>

    // MARK: - Initializers

    init(moyaProvider: MoyaProvider<MovieDBAPI>) {
        self.provider = moyaProvider
    }

    // MARK: - Conforms MoviesWorkerProtocol

    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, NetworkError>) -> Void) {
        provider.request(.fetchMovies(language: language, page: page), completion: completion)
    }
}
