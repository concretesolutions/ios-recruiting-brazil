//
//  FavoriteMoviesTableView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 26/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

final class FavoriteMoviesTableView: UITableView {}
extension FavoriteMoviesTableView: ViewCode {
    
    func design() {
        self.register(FavoriteMoviesCell.self, forCellReuseIdentifier: FavoriteMoviesCell.identifier)
        self.backgroundColor = .clear
        self.rowHeight = 120.0
    }
}
