//
//  SearchBarDelegate.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    private var presenter: MoviesPresentation
    private var currentSearch: String = ""
    
    init(presenter: MoviesPresentation) {
        self.presenter = presenter
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            if text.count == 0 && self.currentSearch.count > 0 {
                searchBar.resignFirstResponder()
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
        searchBar.text = nil
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let movieTitle = searchBar.text {
            self.currentSearch = movieTitle
            if movieTitle.trimmingCharacters(in: CharacterSet(charactersIn: " ")).count > 0 {
                self.presenter.didSearchMovies(withTitle: movieTitle)
            } else {
                searchBar.setShowsCancelButton(false, animated: true)
                searchBar.text = nil
            }
        } else {
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }
    
}
