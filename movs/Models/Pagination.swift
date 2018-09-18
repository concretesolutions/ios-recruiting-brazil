//
//  Pagination.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

struct Pagination {
    var currentPage: Int = 1
    var totalPages: Int = 0
    
    func nextPage() -> Bool {
        if self.currentPage < self.totalPages  {
            return true
        }
        
        return false
    }
}
