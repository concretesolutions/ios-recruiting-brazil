//
//  FavoritesScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum FavoritesScreenFactory {
    static func makeFavorites() -> UIViewController {
        let provider = MovieRealmDbService()
        let worker = MoviesRealmWorker(provider: provider)

        let presenter = FavoritesPresenter()

        let interactor = FavoritesInteractor(worker: worker, presenter: presenter)

        let favoritesViewController = FavoritesViewController(interactor: interactor)
        presenter.viewController = favoritesViewController

        return favoritesViewController
    }
}
