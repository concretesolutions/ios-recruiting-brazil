//
//  FavoritesFethErrorState.swift
//  Mov
//
//  Created by Miguel Nery on 03/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesFethErrorState: FavoritesBaseState {
    
    override func hideViews() -> [UIView] {
        return [favoritesView.noResultsView, favoritesView.tableView]
    }
    
    override func showViews() -> [UIView] {
        return [favoritesView.fetchErrorView]
    }
    
    override func onEnter() {
        favoritesView.searchBar.isUserInteractionEnabled = false
    }
    
    override func onExit() {
        favoritesView.searchBar.isUserInteractionEnabled = true
    }
}
