//
//  FavoritesScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 27/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit
import SwipeCellKit

final class FavoritesScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var moviesTableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    private var models = [Movie]() {
        didSet {
            moviesTableView.reloadData()
        }
    }
    private let dataPresenter = FavoritesDataPresenter.shared
}

// MARK: - Lifecycle
extension FavoritesScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }
}

// MARK: - Private
extension FavoritesScreen {
    private func setupUI() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        searchBar.backgroundColor = .yellowConcrete
        moviesTableView.register(FavoriteListCell.self)
        moviesTableView.tableFooterView = UIView()
    }

    private func fetchData() {
        dataPresenter.getFavoriteMovies { movies in
            self.models = movies
        }
    }

    private func unfavorited(movie: Movie) {
        dataPresenter.favoritedAction(movie.movieId)
        fetchData()

        let notificationName = Notification.Name("test")
        NotificationCenter.default.post(Notification(name: notificationName))
    }
}

// MARK: - UITableViewDataSource
extension FavoritesScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(movie: models[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - SwipeTableViewCellDelegate
extension FavoritesScreen: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath,
                   for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let unfavoriteAction
            = SwipeAction(style: .destructive,
                          title: "Unfavorite") { [weak self] action, indexPath in
                guard let `self` = self else { return }
                self.unfavorited(movie: self.models[indexPath.row])
        }

        return [unfavoriteAction]
    }
}
