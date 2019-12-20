//
//  FavoriteMoviesViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 19/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

    // MARK: - Screen

    private lazy var screen = FavoriteMoviesScreen()

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Favorites"
        self.navigationItem.largeTitleDisplayMode = .always

        DataProvider.shared.didChangeFavorites = {
            DispatchQueue.main.async {
                self.screen.tableView.reloadData()
            }
        }
    }
}

extension FavoriteMoviesViewController: FavoriteMoviesScreenDelegate {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return DataProvider.shared.favoriteMovies.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteMovieCell.reusableIdentifier, for: indexPath) as? FavoriteMovieCell else {
            fatalError("Wrong table view cell type")
        }

        cell.configure(with: DataProvider.shared.favoriteMovies[indexPath.section])

        return cell
    }

    // MARK: - UITabelViewDelegate

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = MovieDetailViewController(movie: DataProvider.shared.favoriteMovies[indexPath.section])
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavoriteAction = UIContextualAction(style: .normal, title: "Unfavorite", handler: { (_, _, success) in
            DataProvider.shared.favoriteMovies[indexPath.section].isFavorite = false
            success(true)
        })
        unfavoriteAction.backgroundColor = .red

        return UISwipeActionsConfiguration(actions: [unfavoriteAction])
    }
}
