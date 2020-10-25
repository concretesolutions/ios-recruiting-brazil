//
//  TabBarViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Private functions

    private func setup() {
        let moviesViewController = MoviesScreenFactory.makeMovies()
        let favoritesViwController = FavoritesScreenFactory.makeFavorites()

        viewControllers = [moviesViewController, favoritesViwController]
    }
}
