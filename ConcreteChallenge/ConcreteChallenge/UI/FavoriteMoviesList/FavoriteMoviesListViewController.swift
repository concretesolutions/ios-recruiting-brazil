//
//  FavoriteMoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class FavoriteMoviesListViewController: UIViewController {

    private let favoriteMoviesListView = FavoriteMoviesListView()
    private let viewModel = FavoriteMoviesListViewModel()

    override func loadView() {
        view = favoriteMoviesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = viewModel.navigationTitle

        favoriteMoviesListView.tableView.delegate = self
        favoriteMoviesListView.tableView.dataSource = self

        // Bind view model
        viewModel.didStateChange = shouldChangeViewState(to:)
        viewModel.didDeleteItem = shouldRemoveItem(at:)
    }

    func shouldRemoveItem(at indexPath: IndexPath) {
        favoriteMoviesListView.tableView.deleteRows(at: [indexPath], with: .fade)
    }

    func shouldChangeViewState(to newState: FavoriteMoviesListViewModel.State) {
        favoriteMoviesListView.isEmptyState = newState == .empty
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FavoriteMoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoritesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as FavoriteMovieTableViewCell

        let favorite = viewModel.favorite(at: indexPath)
        cell.setup(favorite: favorite)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let favorite = viewModel.favorite(at: indexPath)
        let actionTitle = "Remover favorito"
        let unfavoriteAction = UIContextualAction(style: .destructive, title: actionTitle) { (_, _, completionHandler) in
            CoreDataStore.delete(favorite)
            completionHandler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [unfavoriteAction])

        return configuration
    }
}
