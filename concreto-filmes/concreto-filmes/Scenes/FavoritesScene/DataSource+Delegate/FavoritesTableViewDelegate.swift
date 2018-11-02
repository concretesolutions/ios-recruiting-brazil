//
//  FavoritesTableViewDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 01/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension FavoritesViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToMovieDetail(shouldFilter: self.isFiltering, index: indexPath.item)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            interactor?.deleteMovie(at: indexPath.item, filter: self.isFiltering)
            self.displayedMovies.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
