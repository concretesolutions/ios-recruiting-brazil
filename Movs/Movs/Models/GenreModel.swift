//
//  GenreModel.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import SwiftyJSON

fileprivate let JSON_ID_KEY = "id"
fileprivate let JSON_NAME_KEY = "name"

class GenreModel {
    var id: Int
    var name: String
    
    init(json: JSON) {
        self.id = json[JSON_ID_KEY].intValue
        self.name = json[JSON_NAME_KEY].stringValue
    }
}
