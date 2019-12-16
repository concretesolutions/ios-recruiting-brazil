//
//  SearchController.swift
//  movies
//
//  Created by Jacqueline Alves on 12/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

final class SearchController: UISearchController {
    private let textDidChangePublisher = PassthroughSubject<String?, Never>()
    var publisher: AnyPublisher<String?, Never> // Send changes in search bar text to subscribers
    
    init() {
        // Erase publishers
        publisher = textDidChangePublisher.eraseToAnyPublisher()
        
        super.init(searchResultsController: nil)
        
        self.obscuresBackgroundDuringPresentation = false
        self.searchBar.delegate = self // Set this as search bar delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Delegate methods
extension SearchController: UISearchBarDelegate {
    
    /// Called when something is written on seach bar
    /// - Parameters:
    ///   - searchBar: Search bar
    ///   - searchText: Written text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textDidChangePublisher.send(searchBar.text) // Send changes to publisher
    }
    
    /// Called when end editing text
    /// - Parameter searchBar: Search bar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        textDidChangePublisher.send(searchBar.text) // Send changes to publisher
    }
    
    /// Called when cancel burron is clicked
    /// - Parameter searchBar: Search bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        textDidChangePublisher.send("")
    }
}
