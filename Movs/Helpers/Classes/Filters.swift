//
//  Filters.swift
//  Movs
//
//  Created by Gabriel D'Luca on 23/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

// MARK: - Protocol Composition

protocol HasGenreFilter {
    var genresNames: Set<String>! { get set }
}

protocol HasYearFilter {
    var year: Int! { get set }
}

// MARK: - Dependencies

class Filters: HasGenreFilter, HasYearFilter {
    
    // MARK: Properties
    
    var genresNames: Set<String>!
    var year: Int!

    // MARK: Initializers and Deinitializers
    
    init(genresNames: Set<String>? = nil, year: Int? = nil) {
        self.genresNames = genresNames
        self.year = year
    }
}
