//
//  FilterSelectData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct FilterSelectData {
    var id:Int
    var filterName:String
    var filterValue:String
    var resultData:[FilterResultData]
    
    init(id:Int, filterName:String, filterValue:String, resultData:[FilterResultData]) {
        self.id = id
        self.filterName = filterName
        self.filterValue = filterValue
        self.resultData = resultData
    }
}
