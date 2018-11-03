//
//  FiltersRouter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

class FiltersRouter: FiltersRoutingLogic, FiltersDataPassing {
    weak var viewController: FiltersViewController!
    var dataStore: FiltersDataStore?
    
    func showFiltersOption() {
        if let type = dataStore?.type {
            let filtersOptionController = FiltersOptionViewController(filter: type)
            filtersOptionController.dateFilter = viewController.dateFilter
            filtersOptionController.genreFilter = viewController.genreFilter
            filtersOptionController.filterSelected = viewController.filter
            viewController.show(filtersOptionController, sender: nil)
        }
    }
}
