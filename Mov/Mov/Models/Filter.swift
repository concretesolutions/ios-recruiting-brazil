//
//  Filter.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation

struct Filter {
    
    var property: String = ""
    var values = [String]()
    
    init(property: String) {
        self.property = property
    }
    
}
