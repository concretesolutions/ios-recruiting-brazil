//
//  Movie.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift

struct MovieJSON: Decodable {
    var id = 0
    var title: String? = ""
    var poster_path: String? = ""
    var backdrop_path: String? = ""
    var overview: String? = ""
    var release_date: String? = ""
}

class Movie: Object{
    @objc dynamic var id = 0
    @objc dynamic var title: String? = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var release_date: String = ""
    
    let genre_ids: List = List<Int>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
