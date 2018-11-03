//
//  FavoritesRouter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FavoritesRouter: FavoritesRoutingLogic {
    weak var viewController: FavoritesViewController!
    
    func showFilters() {
        let filtersViewController = FiltersViewController()
        filtersViewController.dateFilter = viewController.dateFilter
        filtersViewController.genreFilter = viewController.genreFilter
        filtersViewController.activeFilters = viewController.activeFilters
        filtersViewController.filterApply = viewController.applyFilters
        viewController.show(filtersViewController, sender: nil)
    }
}
