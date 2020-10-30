//
//  MovieDetailsInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetailsInteractor: MovieDetailsBusinessLogic {
    private let worker: MovieDetailsWorkerProtocol
    private let presenter: MovieDetailsPresenter

    // MARK: - Initializers

    init(worker: MovieDetailsWorkerProtocol, presenter: MovieDetailsPresenter) {
        self.worker = worker
        self.presenter = presenter
    }
}
