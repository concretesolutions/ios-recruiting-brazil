//
//  MovieDetailsScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit
import Moya

enum MovieDetailsScreenFactory {
    static func makeMoviesDetails(movie: Movie) -> UIViewController {
        let moyaProviderStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        let moyaProvider = MoyaProvider<MovieDBAPI>(stubClosure: moyaProviderStubClosure, plugins: [NetworkLoggerPlugin()])
        let moyaWorker = MovieDetailsMoyaWorker(provider: moyaProvider)

        let realmWorker = MovieDetailsRealmWorker()

        let presenter = MovieDetailsPresenter()

        let interactor = MovieDetailsInteractor(moyaWorker: moyaWorker, realmWorker: realmWorker, presenter: presenter)

        let movieDetailsViewController = MovieDetailsViewController(movie: movie, interactor: interactor)
        presenter.viewController = movieDetailsViewController

        return movieDetailsViewController
    }
}
