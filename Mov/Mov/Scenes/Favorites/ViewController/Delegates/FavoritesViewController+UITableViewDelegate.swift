//
//  FavoritesViewController+UITableViewDelegate.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FavoritesTableViewCell.defaultHeight
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavoriteAction = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            
            self.interactor?.toggleFavoriteMovie(at: indexPath.row)
        }
        
        return [unfavoriteAction]
    }
}

