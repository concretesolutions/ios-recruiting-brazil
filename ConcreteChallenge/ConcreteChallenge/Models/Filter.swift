//
//  Filter.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift

class Filter: Object {
    @objc dynamic var id = 0
    var genres = List<Genre>()
    var years = List<Int>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
