//
//  MoviesVC+SearchBarDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredMovies = movies.filter({ (text) -> Bool in
            let tmp: NSString = (text.title as NSString?)!
            let range = tmp.range(of: searchController.searchBar.text!, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if searchController.searchBar.text! == "" {
            textSearched  = ""
            isSearchActive = false
        } else {
            textSearched = searchController.searchBar.text!
            self.isSearchActive = true
        }
        self.moviesCollectionView.reloadData()
    }
    
}
