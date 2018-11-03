//
//  FiltersOptionDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionDisplayLogic: class {
    /**
     Display the filters on screen.
     
     - parameters:
         - viewModel: Data to be displayed.
     */
    func displayFilters(viewModel: Filters.Option.ViewModel)
}
