//
//  FavoritesSearchBarDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 01/11/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension FavoritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.isFiltering = false
        } else {
            self.isFiltering = true
        }
    }
}
