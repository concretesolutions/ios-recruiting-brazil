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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        User.current.favorites = Movie.retrieveFavoriteList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Movie.saveFavoriteList(User.current.favorites)
    }
    
    /// Adds the SearchController to the View
    func setSearchController(navBarTitle:String){
        self.title = navBarTitle
        
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
