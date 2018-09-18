//
//  GenreObject.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import RealmSwift

class GenreObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
