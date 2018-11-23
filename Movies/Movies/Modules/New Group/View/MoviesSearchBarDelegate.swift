//
//  SearchBarDelegate.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    // MARK: - Properties
    
    private var presenter: MoviesPresentation
    private var currentSearch: String = ""
    private var viewController: UIViewController!
    
    // MARK: - Initializers
    
    init(presenter: MoviesPresentation, viewController: UIViewController) {
        self.presenter = presenter
        self.viewController = viewController
    }
    
    // MARK: - UISearchBarDelegate protocol functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text.count == 0 && self.currentSearch.count > 0 {
                searchBar.resignFirstResponder()
                self.currentSearch = ""
                self.viewController.showActivityIndicator()
                self.presenter.didFinishSearch()
                return
            }
        }
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchBar.text = ""
        self.currentSearch = ""
        self.viewController.showActivityIndicator()
        self.presenter.didFinishSearch()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let movieTitle = searchBar.text?.trimmingCharacters(in: CharacterSet(charactersIn: " ")) {
            if movieTitle.count > 0 {
                if movieTitle != currentSearch {
                    self.currentSearch = movieTitle
                    self.viewController.showActivityIndicator()
                    self.presenter.didSearchMovies(withTitle: movieTitle)
                } else {
                    searchBar.resignFirstResponder()
                    searchBar.setShowsCancelButton(false, animated: true)
                }
            } else {
                searchBar.setShowsCancelButton(false, animated: true)
                searchBar.text = ""
                self.currentSearch = ""
                self.viewController.showActivityIndicator()
                self.presenter.didFinishSearch()
            }
        } else {
            searchBar.setShowsCancelButton(false, animated: true)
            self.currentSearch = ""
            self.viewController.showActivityIndicator()
            self.presenter.didFinishSearch()
        }
    }
    
}
