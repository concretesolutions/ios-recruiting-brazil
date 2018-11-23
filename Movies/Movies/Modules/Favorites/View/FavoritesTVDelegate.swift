//
//  FavoritesTVDelegate.swift
//  Movies
//
//  Created by Renan Germano on 23/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class FavoritesTVDelegate: NSObject, UITableViewDelegate {

    // MARK: - Properties
    
    private var presenter: FavoritesPresentation
    
    // MARK: - Initializers
    
    init(presenter: FavoritesPresentation) {
        self.presenter = presenter
    }
    
    // MARK: - UITableViewDelegate protocol functions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let favoriteCell = tableView.cellForRow(at: indexPath) as? FavoriteTableViewCell {
            self.presenter.didSelect(movie: favoriteCell.movie)
        }
    }
    
    
}
