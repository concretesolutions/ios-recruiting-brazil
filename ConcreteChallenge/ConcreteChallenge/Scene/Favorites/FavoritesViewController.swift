//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 12/01/20.
//  Copyright © 2020 Marcos Santos. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    let favoritesView = FavoritesView()

    var viewModel: FavoritesViewModel!

    var tableViewDataSource = TableViewDataSource<MovieTableViewCell>(viewModels: [])

    init(viewModel: FavoritesViewModel = FavoritesViewModel()) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)

        view = favoritesView
        title = "Favorites"

        favoritesView.tableView.register(MovieTableViewCell.self)
        favoritesView.tableView.dataSource = tableViewDataSource
        favoritesView.tableView.delegate = self

        viewModel.setLoadingLayout = favoritesView.setLoadingLayout
        viewModel.setEmptyLayout = favoritesView.setEmptyLayout
        viewModel.setShowLayout = favoritesView.setShowLayout
        viewModel.updateData = updateData
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFavorites()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(viewModels: [MovieCellViewModel]) {
        tableViewDataSource.viewModels = viewModels
        favoritesView.tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Unfavorite",
                                        handler: { [weak self] (_, _, completion) in
            self?.tableViewDataSource.viewModels[indexPath.item].favorite()
            self?.tableViewDataSource.viewModels.remove(at: indexPath.item)
            self?.favoritesView.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        })
            .set(\.image, to: UIImage.Favorite.fullIcon)

        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectMovie(index: indexPath.item)
    }
}
