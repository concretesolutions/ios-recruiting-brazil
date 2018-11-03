//
//  FiltersOptionBussinessLogic.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersOptionBussinessLogic {
    func filtersTo(request: Filters.Option.Request)
    func selectFilter(at index: Int) -> (String, String)
}
