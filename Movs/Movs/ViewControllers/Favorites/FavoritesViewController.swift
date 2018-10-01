//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    enum Constants {
        static let nibName = "FavoritesViewController"
        static let title = "Favorites"
        static let cellNibName = "FavoritesTableViewCell"
    }

    @IBOutlet var favoritesTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        self.title = Constants.title
        tabBarItem.title = Constants.title
        tabBarItem.image = UIImage(named: "tabItemFavorites")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }

    // MARK: - Private methods

    private func setupSearchBar() {
        searchController.searchBar.placeholder = "Search favorite"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
    }

    private func setupTableView() {
        favoritesTableView.register(
            UINib(nibName: Constants.cellNibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellNibName
        )
        favoritesTableView.estimatedRowHeight = 100
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching() {
            return 1
        }
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellNibName,
            for: indexPath
        )
        guard let favoriteCell = cell as? FavoritesTableViewCell else {
            fatalError("Cell not configured")
        }
        // TODO: setup cell
        return favoriteCell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FavoritesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.isActive {
            print("Search is active")
        } else {
            print("Search is NOT active")
        }
        favoritesTableView.reloadData()
    }

    /**
     Return whether the user is searching for a specific movie.
     */
    func isSearching() -> Bool {
        if let text = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces) {
            return !text.isEmpty
        }
        return false
    }
}
