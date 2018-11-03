//
//  FiltersDataStore.swift
//  Movs
//
//  Created by Ricardo Rachaus on 03/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Foundation

protocol FiltersDataStore {
    /// Type of filter
    var type: Filters.FiltersType? { get set }
}
