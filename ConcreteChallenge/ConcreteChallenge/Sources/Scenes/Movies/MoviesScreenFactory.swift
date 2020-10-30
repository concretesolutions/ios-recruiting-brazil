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
    static func makeMovies(delegate: MoviesViewControllerDelegate) -> UIViewController {
        let providerStubClosure = MoyaProvider<MovieDBAPI>.neverStub
        let provider = MoyaProvider<MovieDBAPI>(stubClosure: providerStubClosure, plugins: [NetworkLoggerPlugin()])
        let worker = MoviesWorker(provider: provider)

        let presenter = MoviesPresenter()

        let interactor = MoviesInteractor(worker: worker, presenter: presenter)

        let moviesViewController = MoviesViewController(interactor: interactor)
        moviesViewController.delegate = delegate
        presenter.viewController = moviesViewController

        return moviesViewController
    }
}
