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
    }

    private func fetchData() {
        dataPresenter.getFavoriteMovies { movies in
            self.models = movies
        }
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
		cell.textLabel?.text = models[indexPath.row].name
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

        let unfavoriteAction = SwipeAction(style: .destructive,
                                           title: "Unfavorite") { action, indexPath in

        }

        return [unfavoriteAction]
    }
}
