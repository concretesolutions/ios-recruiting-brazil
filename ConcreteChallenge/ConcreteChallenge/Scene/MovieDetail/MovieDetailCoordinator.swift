//
//  MovieDetailCoordinator.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 19/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

struct MovieDetailCoordinator: Coordinator {
    var presenter: UINavigationController
    var rootViewController: MovieDetailViewController

    init(presenter: UINavigationController,
         movieDetailViewController: MovieDetailViewController) {
        self.presenter = presenter
        self.rootViewController = movieDetailViewController
    }

    func start() {
        self.presenter.pushViewController(rootViewController, animated: true)
    }
}
