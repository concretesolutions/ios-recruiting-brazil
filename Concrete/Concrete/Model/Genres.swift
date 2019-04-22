//
//  Genres.swift
//  Concrete
//
//  Created by Vinicius Brito on 21/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

struct Genres: Codable {
    let genres: [Genre]
}

class Genre: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var name: String

    override class func primaryKey() -> String? {
        return "id"
    }
}
