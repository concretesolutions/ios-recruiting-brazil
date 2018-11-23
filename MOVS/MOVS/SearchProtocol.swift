//
//  SearchDelegate.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 21/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

protocol SearchProtocol: UISearchResultsUpdating {
    var searchController: UISearchController { get set }
    
    var isSearchBarEmpety:Bool { get }
    
    var isFiltering: Bool { get }
}

extension SearchProtocol{
    var isSearchBarEmpety:Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpety
    }
}
