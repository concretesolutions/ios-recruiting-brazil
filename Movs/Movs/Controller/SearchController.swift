//
//  SearchController.swift
//  Movs
//
//  Created by Lucca Ferreira on 10/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class SearchController: UISearchController {

    required init(withPlaceholder placeholder: String, searchResultsUpdater: UISearchResultsUpdating) {
        super.init(nibName: nil, bundle: nil)
        self.searchResultsUpdater = searchResultsUpdater
        self.searchBar.placeholder = placeholder
        self.obscuresBackgroundDuringPresentation = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
