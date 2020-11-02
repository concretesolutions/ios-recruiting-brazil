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
    static func make(movie: Movie) -> UIViewController {
        let provider = MovieRealmDbService()
        let worker = RealmWorker(provider: provider)

        let presenter = MovieDetailsPresenter()

        let interactor = MovieDetailsInteractor(worker: worker, presenter: presenter)

        let movieDetailsViewController = MovieDetailsViewController(movie: movie, interactor: interactor)
        presenter.viewController = movieDetailsViewController

        return movieDetailsViewController
    }
}
