//
//  UITableView+Extension.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 20/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit

/// Enum to help organize the set of Identifiers for UITableView
enum TableViewCell: String {
    case favoriteCell = "FavoriteTableViewCell"
}

extension UITableView {
    /// Streamlined method to register UITableViewCell UINib to UITableView
    func registerCellForType(_ type: TableViewCell){
        self.register(UINib(nibName: type.rawValue, bundle: nil), forCellReuseIdentifier: type.rawValue)
    }
}
