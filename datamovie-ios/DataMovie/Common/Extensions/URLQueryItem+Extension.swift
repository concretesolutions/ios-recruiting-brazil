//
//  URLQueryItem+Extension.swift
//  DataMovie
//
//  Created by Andre on 25/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

extension URLQueryItem {
    
    init(item: QueryItem, value: String) {
        self.init(name: item.key, value: value)
    }
    
    init(item: QueryItem, value: QueryItem.DefaultValues) {
        self.init(name: item.key, value: value.rawValue)
    }
    
    init(item: QueryItem, value: Configuration.ItemAppend) {
        self.init(name: item.key, value: value.rawValue)
    }
    
}
