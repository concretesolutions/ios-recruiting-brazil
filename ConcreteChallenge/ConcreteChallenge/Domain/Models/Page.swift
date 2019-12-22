//
//  Page.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation

struct Page<ItemType: Decodable>: Decodable {
    var items: [ItemType]
    var pageNumber: Int
    var totalOfItems: Int?
    var totalOfPages: Int?
    
    var numberOfItem: Int {
        return items.count
    }
    
    var nextPage: Int? {
        let nextPage = pageNumber + 1
        guard let totalOfPages = self.totalOfPages else {
            return nextPage
        }
        
        guard nextPage <= totalOfPages else {
            return nil
        }
        
        return nextPage
    }
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case items = "results"
        case totalOfItems = "total_results"
        case totalOfPages = "total_pages"
    }
    
    init(items: [ItemType], totalOfPages: Int? = nil) {
        self.init()
        self.items = items
        self.totalOfPages = totalOfPages
    }
    
    init() {
        self.items = []
        self.pageNumber = 0
    }
    
    mutating func addNewPage(_ page: Page<ItemType>) {
        items.append(contentsOf: page.items)
        
        pageNumber += 1
        self.totalOfPages = page.totalOfPages
    }
    
    func isValidPosition(_ position: Int) -> Bool {
        return position >= 0 && position < numberOfItem
    }
}
