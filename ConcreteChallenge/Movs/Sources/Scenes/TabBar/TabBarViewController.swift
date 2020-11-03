//
//  TabBarViewController.swift
//  Movs
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TabBarViewController: UITabBarController, UITabBarControllerDelegate, UISearchResultsUpdating {
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false

        let searchBar = searchController.searchBar
        searchBar.placeholder = Strings.search.localizable
        searchBar.tintColor = .black

        return searchController
    }()

    // MARK: - Private constants

    private let tabBarViewControllers: [UIViewController]

    // MARK: - Variables

    weak var tabBarDelegate: TabBarViewControllerDelegate?

    // MARK: - Initializers

    init(tabBarViewControllers: [UIViewController], delegate: TabBarViewControllerDelegate) {
        self.tabBarViewControllers = tabBarViewControllers
        self.tabBarDelegate = delegate

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self

        setupLayout()
    }

    override func setupNavigation() {
        super.setupNavigation()

        title = Strings.movies.localizable

        navigationItem.searchController = searchController
    }

    // MARK: - Functions

    func filter(filter: FilterSearch) {
        tabBarDelegate?.filterSearchTapped(filter: filter, self)
    }

    // MARK: - UITabBarControllerDelegate conforms

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedViewController {
        case is MoviesViewController:
            setupRightNavigationButton(shouldHide: true)
        case is FavoritesViewController:
            setupRightNavigationButton(shouldHide: false)
        default:
            print(Strings.viewControllerNotFound.localizable)
        }
    }

    // MARK: - UISearchResultsUpdating conforms

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }

        filter(filter: FilterSearch(search: text))
    }

    // MARK: - Private functions

    private func setupRightNavigationButton(shouldHide: Bool) {
        let filterIcon = UIImage(assets: .filterIcon)
        let barButtonItem = shouldHide ? nil : UIBarButtonItem(image: filterIcon, style: .plain, target: self, action: #selector(didBarButtonItemTapped))
        barButtonItem?.tintColor = .appBlackLight
        navigationItem.rightBarButtonItem = barButtonItem
    }

    private func setupLayout() {
        setupNavigation()
        setupTabBar()
    }

    private func setupTabBar() {
        viewControllers = tabBarViewControllers
        selectedIndex = 0

        UITabBar.appearance().tintColor = .black
        UITabBar.appearance().barTintColor = .appYellowLight
    }

    // MARK: - Fileprivate functions

    @objc fileprivate func didBarButtonItemTapped() {
        tabBarDelegate?.filterIconTapped(self)
    }
}

private extension Selector {
    static let didBarButtonItemTapped = #selector(TabBarViewController.didBarButtonItemTapped)
}
