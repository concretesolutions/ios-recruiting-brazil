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

    init() {
        let providerStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        provider = MoyaProvider<MovieDBAPI>(stubClosure: providerStubClosure, plugins: [NetworkLoggerPlugin()])
    }

    func getMovies() {
        provider.request(.getMovies) { result in
            switch result {
            case let .success(response):
                print(response.data)
            case let .failure(error):
                print(error)
            }
        }
    }
}
