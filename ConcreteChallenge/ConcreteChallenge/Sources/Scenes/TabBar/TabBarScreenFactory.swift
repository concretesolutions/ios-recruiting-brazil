//
//  TabBarScreenFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum TabBarScreenFactory {
    static func makeTabBar(delegate: MoviesViewControllerDelegate) -> UIViewController {
        let moviesViewController = MoviesScreenFactory.makeMovies(delegate: delegate)
        let moviesTabBarIcon = UITabBarItem()
        moviesTabBarIcon.image = UIImage(assets: .listIcon)
        moviesTabBarIcon.title = Strings.movies.localizable
        moviesViewController.tabBarItem = moviesTabBarIcon

        let favoritesViwController = FavoritesScreenFactory.makeFavorites()
        let favoritesTabBarIcon = UITabBarItem()
        favoritesTabBarIcon.image = UIImage(assets: .favoriteEmptyIcon)
        favoritesTabBarIcon.title = Strings.favorites.localizable
        favoritesViwController.tabBarItem = favoritesTabBarIcon

        let tabBarViewController = TabBarViewController(tabBarViewControllers: [moviesViewController, favoritesViwController])

        return tabBarViewController
    }
}
