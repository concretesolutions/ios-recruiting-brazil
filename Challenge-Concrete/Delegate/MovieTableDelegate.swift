//
//  MovieTableDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class MovieTableDelegate: NSObject, GenericDelegate, UITableViewDelegate {
    
    weak var moviesDelegate: MoviesDelegate?
            
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesDelegate?.didSelectMovie(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavorite = UIContextualAction(style: .destructive, title: "Unfavorite",
          handler: { [weak self] (action, view, completionHandler) in
          
            self?.moviesDelegate?.didFavoriteMovie(at: indexPath.row, turnFavorite: false)
        })
        let configuration = UISwipeActionsConfiguration(actions: [unfavorite])
        return configuration
    }
}
