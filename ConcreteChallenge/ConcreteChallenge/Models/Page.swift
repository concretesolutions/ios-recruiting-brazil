//
//  Page.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

struct Page<ItemType: Codable>: Codable {
    var items: [ItemType]
    var pageNumber: Int
    var totalOfItems: Int
    var totalOfPages: Int
    
    var numberOfItem: Int {
        return items.count
    }
    
    var nextPage: Int {
        return pageNumber + 1
    }
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case items = "results"
        case totalOfItems = "total_results"
        case totalOfPages = "total_pages"
    }
    
    init() {
        self.items = []
        self.pageNumber = 1
        self.totalOfItems = 0
        self.totalOfPages = 0
    }
    
    mutating func addNewPage(_ page: Page<ItemType>) {
        items.append(contentsOf: page.items)
        pageNumber = page.pageNumber
    }
}
