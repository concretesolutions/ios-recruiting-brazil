//
//  MoviesFavoritedVC+UISearchResultsUpdating.swift
//  Movs
//
//  Created by Rafael Douglas on 21/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesFavoritedVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        loadfavoritedMovies(filtering: searchController.searchBar.text!)
        tableView.reloadData()
    }
}
