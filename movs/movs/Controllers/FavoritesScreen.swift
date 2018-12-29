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
    @IBOutlet private weak var tableViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var removeFiltersButton: UIButton!

    // MARK: - Properties
    private var filterIsSet = false
	private let dataPresenter = FavoritesDataPresenter.shared
    private var allModels = [Movie]() {
        didSet {
            filteredModels = allModels
        }
    }

    private var filteredModels = [Movie]() {
        didSet {
            moviesTableView.reloadData()
        }
    }
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterListSegue" {
            guard let screen = segue.destination as? FilterListScreen else { return }
            screen.delegate = self
        }
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
        dataPresenter.getFavoriteMovies(completion: { movies in
            self.allModels = movies
        }) {
            // TO DO
        }
    }

    private func unfavorited(movie: Movie) {
        dataPresenter.favoritedAction(movie.movieId)
        fetchData()

        let notificationName = Notification.Name(Constants.Notifications.updateList)
        NotificationCenter.default.post(Notification(name: notificationName))
    }

    private func setFilter(_ status: Bool) {
		removeFiltersButton.isHidden = !status
        let topForFilterOn: CGFloat = 35.0
        tableViewTopConstraint.constant = status ? topForFilterOn : 0.0
    }
}

// MARK: - UITableViewDataSource
extension FavoritesScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filteredModels.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FavoriteListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(movie: filteredModels[indexPath.row])
        cell.delegate = self
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension FavoritesScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredModels = searchText.isEmpty ? allModels : allModels.filter({ movie -> Bool in
            return movie.name.range(of: searchText, options: .caseInsensitive) != nil
        })
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
                self.unfavorited(movie: self.filteredModels[indexPath.row])
        }

        return [unfavoriteAction]
    }
}

// MARK: - FilterListScreenDelegate
extension FavoritesScreen: FilterListScreenDelegate {
    func appliedFilters() {
		setFilter(true)
    }
}

// MARK: - IBActions
extension FavoritesScreen {
    @IBAction private func tappedRemoveFilters(_ sender: Any) {
        setFilter(false)
    }
}
