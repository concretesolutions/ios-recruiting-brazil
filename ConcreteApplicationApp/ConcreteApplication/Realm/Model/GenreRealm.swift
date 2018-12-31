//
//  GenreRealm.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 22/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import RealmSwift

class GenreRealm: Object{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
