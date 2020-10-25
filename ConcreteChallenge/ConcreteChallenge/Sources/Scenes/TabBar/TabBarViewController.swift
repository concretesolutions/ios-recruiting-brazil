//
//  TabBarViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, ViewCode {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        let searchBar = searchController.searchBar
        searchBar.placeholder = Strings.search.localizable
        searchBar.tintColor = .black

        return searchController
    }()

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - ViewCode conforms

    func setupHierarchy() { }

    func setupConstraints() { }

    func setupConfigurations() {
        setupNavigationBar()
        setupTabBar()
    }

    // MARK: - Private functions

    private func setupNavigationBar() {
        title = Strings.movies.localizable

        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .appYellowLight
        navigationItem.standardAppearance = navigationAppearance
        navigationItem.scrollEdgeAppearance = navigationAppearance
        navigationItem.searchController = searchController
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
        UITabBar.appearance().barTintColor = .appYellowLight
    }
}
