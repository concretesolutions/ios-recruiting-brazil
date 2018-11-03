//
//  FiltersOptionPresentationLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionPresentationLogic {
    /**
     Present filter options request.
     
     - parameters:
         - response: Response of the filters requested.
     */
    func presentFilters(response: Filters.Option.Response)
}
