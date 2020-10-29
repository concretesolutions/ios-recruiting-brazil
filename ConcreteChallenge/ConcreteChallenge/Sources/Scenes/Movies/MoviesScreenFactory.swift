//
//  MoviesScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit
import Moya

enum MoviesScreenFactory {
    static func makeMovies() -> UIViewController {
        let moyaProviderStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        let moyaProvider = MoyaProvider<MovieDBAPI>(stubClosure: moyaProviderStubClosure, plugins: [NetworkLoggerPlugin()])
        let moyaWorker = MoviesMoyaWorker(moyaProvider: moyaProvider)
        let presenter = MoviesPresenter()
        let interactor = MoviesInteractor(moyaWorker: moyaWorker, presenter: presenter)
        let moviesViewController = MoviesViewController(interactor: interactor)
        presenter.viewController = moviesViewController

        return moviesViewController
    }
}
