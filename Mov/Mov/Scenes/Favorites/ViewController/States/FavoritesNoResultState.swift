//
//  FavoritesNoResultState.swift
//  Mov
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesNoResultState: FavoritesBaseState {
    
    var searchRequest = ""
    
    override func hideViews() -> [UIView] {
        return [favoritesView.tableView]
    }
    
    override func showViews() -> [UIView] {
        return [favoritesView.noResultsView]
    }
    
    override func onEnter() {
        favoritesView.noResultsView.errorLabel.text = Texts.noResults(for: searchRequest)
    }
}
