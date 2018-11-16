//
//  GenreRlm.swift
//  Movs
//
//  Created by Erick Lozano Borges on 14/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

class GenreRlm: Object {
    //Properties
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String? = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
