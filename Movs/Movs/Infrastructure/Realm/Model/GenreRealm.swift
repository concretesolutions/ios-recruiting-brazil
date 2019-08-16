//
//  GenreRealm.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import RealmSwift

public class GenreRealm: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
