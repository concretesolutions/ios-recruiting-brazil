//
//  Genre.swift
//  Movs
//
//  Created by Erick Lozano Borges on 14/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import RealmSwift

struct Genre {
    
    var id: Int
    var name: String?
    
    init(id: Int) {
        self.id = id
    }
    
    init(id: Int, name:String) {
        self.id = id
        self.name = name
    }
    
    public init(_ genreRlm: GenreRlm) {
        id = genreRlm.id
        name = genreRlm.name
    }
    
    func rlm() -> GenreRlm {
        return GenreRlm.build({ (objectRlm) in
            objectRlm.id = self.id
            objectRlm.name = self.name
        })
    }
}

extension Genre: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
