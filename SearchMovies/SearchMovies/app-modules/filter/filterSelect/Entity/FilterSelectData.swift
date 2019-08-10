//
//  FilterSelectData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct FilterSelectData {
    var filterName:String
    var filterValue:String
    
    init(filterName:String, filterValue:String) {
        self.filterName = filterName
        self.filterValue = filterValue
    }
}
