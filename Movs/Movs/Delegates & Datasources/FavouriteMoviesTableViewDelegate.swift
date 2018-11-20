//
//  FavouriteMoviesTableViewDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 20/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

protocol MovieUnfavouriteDelegate {
    func unfavourite(movie:Movie)
}

class FavouriteMoviesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var delegate: MovieSelectionDelegate?
    
    private var movies: [Movie]
    
    init(movies: [Movie], delegate: MovieSelectionDelegate) {
        self.movies = movies
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //FIXME: proportinal height
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //FIXME: thumbnail logic
        let movie = movies[indexPath.row]
        delegate?.didSelect(movie: movie)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Unfavourite") { (action, view, handler) in
            self.delegate?.unfavouriteSelected(movie: self.movies[indexPath.row], indexPath: indexPath)
            handler(true)
        }
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
    
}
