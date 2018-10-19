//
//  Filter.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation

struct Filter: Equatable {
    
    var property: String = ""
    var values = [String]()
    var selectedValues = [String]()
    
    init(property: String) {
        self.property = property
    }
    
    static func ==(rhs: Filter, lhs: Filter) -> Bool{
        return rhs.property == lhs.property
    }
}
