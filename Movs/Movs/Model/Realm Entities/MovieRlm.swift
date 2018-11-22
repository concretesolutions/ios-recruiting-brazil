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
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseYear: String = ""
    @objc dynamic var isFavourite: Bool = true
    @objc dynamic var thumbnailData: Data?
    
    override static func primaryKey() -> String? {
        return "id"
    }

}
