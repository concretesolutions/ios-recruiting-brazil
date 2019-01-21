//
//  Genre.swift
//  Movs
//
//  Created by Franclin Cabral on 1/20/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RealmSwift

struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    var id: Int
    var name: String
}

final class GenreObject: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Genre: Persistable {
    typealias ManagedObject = GenreObject
    
    init(managedObject: GenreObject) {
        id = managedObject.id
        name = managedObject.name
    }
    
    func managedObject() -> GenreObject {
        let genre = GenreObject()
        genre.id = id
        genre.name = name
        return genre
    }
}
