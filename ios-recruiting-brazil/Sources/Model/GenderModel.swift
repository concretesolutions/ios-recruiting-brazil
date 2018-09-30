//
//  GenderModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper

struct GenderModel: Mappable {
    var id: Int
    var name: String?
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
    }
    
    init(id: Int) {
        self.id = id
    }
    
    init(JSON: NSDictionary) {
        self.id = JSON["id"] as? Int ?? 0
        self.name = JSON["name"] as? String
    }
}

extension GenderModel: Equatable {
    static func == (lhs: GenderModel, rhs: GenderModel) -> Bool {
        return
            lhs.id == rhs.id
    }
}
