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
        self.filteredMovies = movies.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        self.isSearchActive = true
        self.textSearched = searchText.lowercased()
        self.moviesCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isSearchActive = false
        self.searchBar.text = ""
        self.moviesCollectionView.reloadData()
    }
}
