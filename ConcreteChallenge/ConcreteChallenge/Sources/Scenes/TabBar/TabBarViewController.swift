//
//  TabBarViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)

        let searchBar = searchController.searchBar
        searchBar.placeholder = Strings.search.localizable
        searchBar.tintColor = .black

        return searchController
    }()

    // MARK: - Private constants

    private let tabBarViewControllers: [UIViewController]

    // MARK: - Initializers

    init(tabBarViewControllers: [UIViewController]) {
        self.tabBarViewControllers = tabBarViewControllers
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    // MARK: - Private functions

    private func setupLayout() {
        setupNavigationBar()
        setupTabBar()
    }

    private func setupNavigationBar() {
        title = Strings.movies.localizable

        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.backgroundColor = .appYellowLight
        navigationItem.standardAppearance = navigationAppearance
        navigationItem.scrollEdgeAppearance = navigationAppearance
        navigationItem.searchController = searchController
    }

    private func setupTabBar() {
        viewControllers = tabBarViewControllers
        selectedIndex = 0

        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().barTintColor = .appYellowLight
    }
}
