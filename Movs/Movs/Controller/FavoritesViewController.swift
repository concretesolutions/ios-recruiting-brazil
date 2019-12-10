//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    private let viewModel = FavoritesViewModel()
    private let screen = FavoritesView()

    override func loadView() {
        self.view = screen
        self.screen.tableView.dataSource = self
        self.getSearchController()
    }

}

extension FavoritesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.isEmpty {
            print(searchText.lowercased())
        }
    }

    func getSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movs"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

}

extension FavoritesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        return cell
    }

}
