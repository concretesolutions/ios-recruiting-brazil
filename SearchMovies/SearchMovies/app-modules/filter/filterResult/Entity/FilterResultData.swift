//
//  FilterResultData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 10/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct FilterResultData {
    var id:Int
    var value:String
    var parentId:Int
    
    init(id:Int, value:String, parentId:Int) {
        self.id = id
        self.value = value
        self.parentId = parentId
    }
}

extension FilterResultData : Equatable {
    
}
