//
//  FavoriteMoviesViewController+UITableView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 10/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - UITableViewDelegate

extension FavoriteMoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectItemAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavorite = UIContextualAction(style: .destructive, title: "Unfavorite") { (_, _, _) in
            self.viewModel.removeItemAt(indexPath: indexPath)
        }

        return UISwipeActionsConfiguration(actions: [unfavorite])
    }
}

// MARK: - UITableViewDataSource

extension FavoriteMoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfFavoriteMovies
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMovie", for: indexPath) as? FavoriteMovieTableViewCell else {
            fatalError("Failed to dequeue movies cell as MovieHomeCollectionViewCell")
        }
        
        cell.viewModel = self.viewModel.cellViewModelForItemAt(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
}
