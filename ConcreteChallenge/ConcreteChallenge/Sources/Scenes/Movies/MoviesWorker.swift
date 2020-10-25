//
//  MoviesWorker.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class MoviesWorker: MoviesWorkerProtocol {
    private lazy var engine: NetworkEngine<MovieDBAPI> = {
        let providerStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        let provider = MoyaProvider<MovieDBAPI>(stubClosure: providerStubClosure, plugins: [NetworkLoggerPlugin()])

        return NetworkEngine<MovieDBAPI>(provider: provider)
    }()

    // MARK: - Initializers

    // TODO - DIP engine/provider
    init() {
    }

    // MARK: - Conforms MoviesWorkerProtocol

    func getMovies(completion: @escaping(Result<MoviesPopulariesResponse, NetworkError>) -> Void) {
        engine.request(.getMovies, completion: completion)
    }
}
