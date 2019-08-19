//
//  FavotireMovieTableViewDelegate.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 18/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

final class FavoriteMovieTableViewDelegate: NSObject, UITableViewDelegate{
    
    weak var delegate: MovieSelectionDelegate?
    let movies:[MovieEntity]
    
    init(movies: [MovieEntity], delegate: MovieSelectionDelegate) {
        self.movies = movies
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (rowAction, indexPath) in
            self.delegate?.removeMovie(atIndexPath: indexPath)
            
            //            self.removeMovie(atIndexPath: indexPath)
            //            self.fetchCoreDataObjects()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        return [deleteAction]
    }
    
}
