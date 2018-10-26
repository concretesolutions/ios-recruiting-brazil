//
//  MainScreenSearchBarDelegate.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 25/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit

extension MainScreenViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.interactor?.filterMoviesLocally(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.currentPageForAPI = 1
        self.applicationStatus = .fetchingMore
        self.isFiltering = true
        self.interactor?.fetchQueriedMovies(request: MainScreen.FetchQueryMovies.Request(index: self.currentPageForAPI, text: searchBar.text ?? ""), shouldResetMovies: true, completionBlock: {
            self.applicationStatus = .finish
        })
        dismissKeyboard()
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.searchBar.endEditing(true)
        if(searchBar.text == ""){
            self.isFiltering = false
            self.interactor?.filterMoviesLocally(text: "")
        }
        self.currentPageForAPI = 0
    }
}
