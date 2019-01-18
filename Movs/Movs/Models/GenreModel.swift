//
//  GenreModel.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

fileprivate let JSON_ID_KEY = "id"
fileprivate let JSON_NAME_KEY = "name"

class GenreModel: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String!
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json[JSON_ID_KEY].intValue
        self.name = json[JSON_NAME_KEY].stringValue
    }
}
