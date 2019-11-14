//
//  MovieSearchBarDataSource.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 11/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

protocol MovieSearchBarDataSourceDelegate: class {
    func updateSearchResult(text: String)
    func cancelButton()

}

class MovieSearchBarDataSource: NSObject {
    
    private let delegate: MovieSearchBarDataSourceDelegate
    private let searchController: UISearchController
    
    init(searchController: UISearchController, delegate: MovieSearchBarDataSourceDelegate) {
        self.searchController = searchController
        self.delegate = delegate
        
        super.init()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        self.searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
    }
    
}

extension MovieSearchBarDataSource: UISearchControllerDelegate,UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        self.delegate.updateSearchResult(text: searchString)

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.delegate.cancelButton()
    }

}
