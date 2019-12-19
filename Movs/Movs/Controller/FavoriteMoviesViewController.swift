//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Lucca Ferreira on 01/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import Combine

class FavoriteMoviesViewController: UIViewController {

    private let viewModel = FavoriteMoviesViewModel()
    private let screen = FavoriteMoviesView()

    private var countCancellable: AnyCancellable?

    override func loadView() {
        self.view = self.screen
    }

    required init() {
        super.init(nibName: nil, bundle: nil)
        self.screen.tableView.dataSource = self
        self.screen.tableView.delegate = self

        // Sets SearchController for this ViewController
        self.navigationItem.searchController = SearchController(withPlaceholder: "Search", searchResultsUpdater: self)
        self.definesPresentationContext = true

        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCombine() {
        self.countCancellable = self.viewModel.$count
            .receive(on: RunLoop.main)
            .sink { _ in
                self.screen.tableView.performBatchUpdates({
                    self.screen.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                })
            }
    }

}

extension FavoriteMoviesViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if !searchText.isEmpty {
            print(searchText.lowercased())
        }
    }

}

extension FavoriteMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTableViewCell", for: indexPath) as? FavoritesTableViewCell else {
            print("Caramba")
            return UITableViewCell()
        }
        cell.setup(withViewModel: self.viewModel.viewModel(forCellAt: indexPath))
        return cell
    }

}

extension FavoriteMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeFavoriteAction = UIContextualAction(style: .destructive, title: "Remover favorito") { (_, _, completion) in
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [removeFavoriteAction])
    }

}
