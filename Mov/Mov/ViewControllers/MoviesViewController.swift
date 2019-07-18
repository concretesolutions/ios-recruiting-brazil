//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    
    let screen = MoviesViewControllerScreen()

    let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        self.view = screen
        self.view.backgroundColor = .green
        
        setupSearchController()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        


    }

}

extension MoviesViewController: UISearchResultsUpdating {
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        // TODO
        // https://www.raywenderlich.com/472-uisearchcontroller-tutorial-getting-started
    }
}



