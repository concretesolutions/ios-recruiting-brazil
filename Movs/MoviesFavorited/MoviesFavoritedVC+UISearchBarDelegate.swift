//
//  MoviesFavoritedVC+UISearchBarDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 21/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesFavoritedVC:  UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadfavoritedMovies()
        tableView.reloadData()
       
    }
   
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadfavoritedMovies(filtering: searchBar.text!)
        tableView.reloadData()
    }
}
