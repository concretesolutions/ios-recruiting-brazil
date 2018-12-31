//
//  MovieRealm.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 22/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import RealmSwift

class MovieRealm: Object{
    
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var posterPath: String = ""
    let genres = List<GenreRealm>()
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseYear: String = ""
    @objc dynamic var isFavorite = false
    @objc dynamic var poster : Data?
    
    override static func primaryKey() -> String{
        return "id"
    }
    
}
