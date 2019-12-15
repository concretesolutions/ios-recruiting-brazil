//
//  FavoritesTableDelegate.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 15/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movie = movies[indexPath.row]
        let action = UIContextualAction(style: .destructive, title: "Unfavorite") { (_, _, _) in
            if let name = movie.name {
                self.coreDataManager.deleteMovie(withName: name)
                self.movies.remove(at: indexPath.row)
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        let detailsController = MovieDetailViewController(withMovie: movie)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}
