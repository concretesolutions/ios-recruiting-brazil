//
//  FiltersBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersBussinessLogic {
    func applyFilters(request: Filters.Request.Filters)
    func storeFilter(request: Filters.Request)
}
