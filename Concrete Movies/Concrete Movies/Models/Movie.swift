//
//  Movie.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var image: Data? = nil
    @objc dynamic var details: String = ""
    @objc dynamic var date: String = "N/A"
    @objc dynamic var favorite: Bool = false
    let genre = List<Genre>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
