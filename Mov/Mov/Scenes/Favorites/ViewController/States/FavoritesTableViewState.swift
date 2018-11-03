//
//  FavoritesTableState.swift
//  Mov
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesTableViewState: FavoritesBaseState {
    override func hideViews() -> [UIView] {
        return [favoritesView.noResultsView, favoritesView.fetchErrorView]
    }
    
    override func showViews() -> [UIView] {
        return [favoritesView.tableView]
    }
}
