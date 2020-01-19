//
//  SearchBarViewController.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit

class SearchBarViewController: UIViewController {
    private(set) var searchBarController = UISearchController.init(searchResultsController: nil)
    
    var searchIsFiltered: Bool {
        return self.searchBarController.isActive && !searchIsEmpty
    }
    
    var searchIsEmpty: Bool {
        return self.searchBarController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        setConfigurations()
    }
    
    private func setConfigurations() {
        searchBarController.searchResultsUpdater = self
        searchBarController.obscuresBackgroundDuringPresentation = false
        searchBarController.searchBar.placeholder = NSLocalizedString("Search", comment: "Title of search bar")
        self.navigationItem.searchController = searchBarController
    }
    
    private func setDelegate() {
        searchBarController.delegate = self
        searchBarController.searchBar.delegate = self
    }
}

extension SearchBarViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {}
}
