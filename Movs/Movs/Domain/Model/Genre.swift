//
//  Genre.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import RealmSwift

public struct Genre {

    var id: Int
    var name: String?

    public init(id: Int) {
        self.id = id
    }

    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    func realm() -> GenreRealm {
        return GenreRealm.build({ genreRealm in
            genreRealm.id = self.id
            genreRealm.name = self.name ?? ""
        })
    }

    public init(realmObject: GenreRealm) {
        self.id = realmObject.id
        self.name = realmObject.name
    }

}

extension Genre: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
