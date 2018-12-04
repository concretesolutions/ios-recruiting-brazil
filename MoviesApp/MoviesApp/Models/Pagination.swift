//
//  Pagination.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 03/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import Foundation

class Pagination {
    var page: Int
    let totalResults: Int
    let totalPages: Int
    
    var hasNext: Bool {
        return page < totalPages
    }
    
    var nextPage: Int {
        return page + 1
    }
    
    init(from dictionary: [String:Any]) {
        self.page = Int(safeValue: dictionary["page"])
        self.totalPages = Int(safeValue: dictionary["total_pages"])
        self.totalResults = Int(safeValue: dictionary["total_results"])
    }
    
    init() {
        page = 1
        totalPages = 1
        totalResults = 0
    }
}
