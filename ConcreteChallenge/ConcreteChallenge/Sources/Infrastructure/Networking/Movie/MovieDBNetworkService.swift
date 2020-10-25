//
//  MovieDBNetworkService.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 24/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class MovieDBNetworkService {
    private let movieProvider: MoyaProvider<MovieDBAPI>

    // MARK: - Initializers

    init() {
        let movieProviderStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        movieProvider = MoyaProvider<MovieDBAPI>(stubClosure: movieProviderStubClosure, plugins: [NetworkLoggerPlugin()])
    }

    func getMovies() {
        movieProvider.request(.getMovies) { result in
            switch result {
            case let .success(response):
                print(response.data)
            case let .failure(error):
                print(error)
            }
        }
    }
}
