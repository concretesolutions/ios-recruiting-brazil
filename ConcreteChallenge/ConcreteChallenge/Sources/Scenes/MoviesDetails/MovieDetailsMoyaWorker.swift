//
//  MovieDetailsMoyaWorker.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Moya

final class MovieDetailsMoyaWorker: MovieDetailsMoyaWorkerProtocol {
    private let provider: MoyaProvider<MovieDBAPI>

    // MARK: - Initializers

    init(provider: MoyaProvider<MovieDBAPI>) {
        self.provider = provider
    }
}
