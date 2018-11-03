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
    var id: Int
    var title: String?
    var poster_path: String?
    var backdrop_path: String?
    var overview: String?
    var release_date: String?
    var genre_ids: [Int]?
}

class Movie: Object {
    @objc dynamic var id = 0
    @objc dynamic var title: String = ""
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var year = 0
    @objc dynamic var isSaved: Bool = false
    
    let genres = List<Genre>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
