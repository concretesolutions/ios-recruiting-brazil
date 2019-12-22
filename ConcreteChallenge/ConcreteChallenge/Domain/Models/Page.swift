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
    
    init(items: [ItemType]) {
        self.init()
        self.items = items
    }
    
    init() {
        self.items = []
        self.pageNumber = 0
        self.totalOfItems = 0
        self.totalOfPages = 0
    }
    
    mutating func addNewPage(_ page: Page<ItemType>) {
        items.append(contentsOf: page.items)
        
        pageNumber += 1
    }
    
    func isValidPosition(_ position: Int) -> Bool {
        return position >= 0 && position < numberOfItem
    }
}
