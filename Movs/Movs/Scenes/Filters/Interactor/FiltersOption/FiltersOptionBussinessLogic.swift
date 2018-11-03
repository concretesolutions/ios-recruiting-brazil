//
//  FiltersOptionBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionBussinessLogic {
    /**
     Filters to be requested.
     
     - parameters:
         - request: Filters requested.
     */
    func filtersTo(request: Filters.Option.Request)
    
    /**
     Filter selected at index. Returns the filter predicate and filter name.
     
     - parameters:
         - index: Index of the filter.
     
     - Returns: (predicate, name) : (String, String)
     */
    func selectFilter(at index: Int) -> (String, String)
}
