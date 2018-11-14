//
//  MovieRlm.swift
//  Movs
//
//  Created by Erick Lozano Borges on 14/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

class MovieRlm: Object {
    // Properties
    let genres = List<GenreRlm>()
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var isFavourite: Bool = false
    @objc dynamic var overview: String = ""
    @objc dynamic var thumbFilePath: String = ""
//    @objc dynamic var thumbnail: Data
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
