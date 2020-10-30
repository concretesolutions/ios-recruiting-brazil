//
//  MovieDetailsInteractor.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

final class MovieDetailsInteractor: MovieDetailsBusinessLogic {
    private let moyaWorker: MovieDetailsMoyaWorkerProtocol
    private let realmWorker: MovieDetailsRealmWorkerProtocol
    private let presenter: MovieDetailsPresenter

    // MARK: - Initializers

    init(moyaWorker: MovieDetailsMoyaWorkerProtocol, realmWorker: MovieDetailsRealmWorkerProtocol, presenter: MovieDetailsPresenter) {
        self.moyaWorker = moyaWorker
        self.realmWorker = realmWorker
        self.presenter = presenter
    }
}
