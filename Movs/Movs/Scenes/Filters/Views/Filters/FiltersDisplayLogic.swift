//
//  FiltersDisplayLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersDisplayLogic: class {
    /**
     Apply the filters chosen.
     
     - parameters:
         - viewModel: Filters data to be displayed.
     */
    func applyFilter(viewModel: Filters.ViewModel)
}
