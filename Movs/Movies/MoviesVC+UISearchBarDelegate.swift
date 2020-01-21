//
//  MoviesVC+UISearchBarDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 19/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesVC: UISearchBarDelegate
{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMovies = movies.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearchActive = true
        textSearched = searchText.lowercased()
        moviesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchActive = false
        searchBar.text = ""
        moviesCollectionView.reloadData()
    }
}
