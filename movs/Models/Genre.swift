//
//  Genre.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

struct Genre {
    let id: Int
    let name: String
    
    init(fromDictionary dictionary: NSDictionary) {
        self.id = dictionary["id"] as? Int ?? 0
        self.name = dictionary["name"] as? String ?? ""
    }
}
