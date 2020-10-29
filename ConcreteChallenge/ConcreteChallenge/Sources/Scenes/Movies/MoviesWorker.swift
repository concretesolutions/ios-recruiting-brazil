//
//  MoviesWorker.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class MoviesWorker: MoviesWorkerProtocol {
    private let provider: MoyaProvider<MovieDBAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<MovieDBAPI>) {
        self.provider = provider
    }

    // MARK: - Conforms MoviesWorkerProtocol

    func fetchMovies(language: String, page: Int, completion: @escaping (Result<MoviesPopulariesResponse, NetworkError>) -> Void) {
        provider.request(.fetchMovies(language: language, page: page), completion: completion)
    }
}
