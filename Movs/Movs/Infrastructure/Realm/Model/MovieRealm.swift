//
//  MovieRealm.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import RealmSwift

public class MovieRealm: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    let genres = List<GenreRealm>()
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseYear: String = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var poster: Data?

    public override static func primaryKey() -> String {
        return "id"
    }
}
