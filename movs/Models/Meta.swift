//
//  Meta.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

struct Meta {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    
    init(fromDictionary dictionary: NSDictionary) {
        self.page = dictionary["page"] as? Int ?? 0
        self.totalResults = dictionary["total_results"] as? Int ?? 0
        self.totalPages = dictionary["total_pages"] as? Int ?? 0
    }
}
