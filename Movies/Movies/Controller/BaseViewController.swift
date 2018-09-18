//
//  BaseViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UISearchResultsUpdating {
    
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
    }
    
    /// Adds the SearchController to the View
    private func setSearchController(){
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a movie"
        definesPresentationContext = true
    
        navigationItem.searchController = searchController
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
