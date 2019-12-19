//
//  PopularMoviesViewController+UISearchBar.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

extension PopularMoviesViewController {
    func configureSearchBar() {
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search movies..."
        self.searchController.searchBar.delegate = self
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
}

// MARK: - UISearchBarDelegate

extension PopularMoviesViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if self.displayedError == .networkError {
            self.showSearchError()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if self.displayedError == .searchAndNetworkError {
            self.displayedError = .networkError
            self.showNetworkError()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension PopularMoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        self.viewModel.filterMovies(for: searchText)
    }
}
