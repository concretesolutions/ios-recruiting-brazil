//
//  FavoriteMoviesTableViewDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

protocol MovieUnfavoriteDelegate: class {
    func unfavorite(movie:Movie)
}

class FavoriteMoviesTableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: MovieSelectionDelegate?
    
    private var movies: [Movie]
    
    init(movies: [Movie], delegate: MovieSelectionDelegate) {
        self.movies = movies
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        delegate?.didSelect(movie: movie)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, handler) in
            self.delegate?.unfavoriteSelected(movie: self.movies[indexPath.row], indexPath: indexPath)
            handler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
