//
//  FiltersBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersBussinessLogic {
    /**
     Apply the filters.
     
     - parameters:
         - request: Filters request to be applied.
     */
    func applyFilters(request: Filters.Request.Filters)
    
    /**
     Store the type of filter.
     
     - parameters:
         - request: Filter requested.
     */
    func storeFilter(request: Filters.Request)
}
