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
    
    // Properties
    private let viewModel = FavoriteMoviesViewModel()
    private lazy var screen: FavoriteMoviesView = {
        return FavoriteMoviesView(forController: self)
    }()
    private let searchController: SearchController = SearchController(withPlaceholder: "Search")
    private var state: ExceptionView.State = .none

    // Cancellables
    private var stateCancellable: AnyCancellable?
    private var movieCountCancellable: AnyCancellable?
    private var networkCancellable: AnyCancellable?

    override func loadView() {
        self.view = self.screen
    }

    required init() {
        super.init(nibName: nil, bundle: nil)

        // Sets SearchController for this ViewController
        self.navigationItem.searchController = self.searchController
        self.definesPresentationContext = true

        self.setCombine()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCombine() {
        self.movieCountCancellable = self.viewModel.$movieCount
            .receive(on: RunLoop.main)
            .sink { _ in
                self.screen.reloadTableView()
            }
        self.stateCancellable = self.viewModel.$state
            .receive(on: RunLoop.main)
            .assign(to: \.state, on: self.screen)
        self.networkCancellable = self.viewModel.$withoutNetwork
            .receive(on: RunLoop.main)
            .sink(receiveValue: { (value) in
                if value == true && self.state != .withoutNetwork {
                    let alert = UIAlertController(title: "Connection problem",
                                                  message: "We encountered problems with your connection.",
                                                  preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        self.viewModel.setSearchCombine(forSearchController: self.searchController)
        self.viewModel.setNetworkCombine()
    }

}

extension FavoriteMoviesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.movieCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoritesTableViewCell",
                                                       for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        cell.setup(withViewModel: self.viewModel.viewModelForCell(at: indexPath))
        return cell
    }

}

extension FavoriteMoviesViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeFavoriteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completion) in
            guard let cell = tableView.cellForRow(at: indexPath) as? FavoritesTableViewCell else {
                completion(false)
                return
            }
            cell.toggleFavorite()
            completion(true)
        }
        removeFavoriteAction.image = UIImage(systemName: "heart.slash")
        return UISwipeActionsConfiguration(actions: [removeFavoriteAction])
    }

}
