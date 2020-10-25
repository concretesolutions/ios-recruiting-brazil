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
        setupNavigationBar()
        setupTabBar()
    }

    private func setupNavigationBar() {
        title = Strings.movies.localizable
    }

    private func setupTabBar() {
        let moviesViewController = MoviesScreenFactory.makeMovies()
        let moviesTabBarIcon = UITabBarItem()
        moviesTabBarIcon.image = UIImage(assets: .listIcon)
        moviesViewController.tabBarItem = moviesTabBarIcon

        let favoritesViwController = FavoritesScreenFactory.makeFavorites()
        let favoritesTabBarIcon = UITabBarItem()
        favoritesTabBarIcon.image = UIImage(assets: .favoriteEmptyIcon)
        favoritesViwController.tabBarItem = favoritesTabBarIcon

        viewControllers = [moviesViewController, favoritesViwController]
        selectedViewController = moviesViewController

        UITabBar.appearance().tintColor = .black
    }
}
