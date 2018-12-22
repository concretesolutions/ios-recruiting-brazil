//
//  Genre.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import RealmSwift

struct Genre{
    
    var id:Int
    var name: String?
    
    public init(id: Int){
        self.id = id
    }
    
    public init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
    func realm() -> GenreRealm{
        return GenreRealm.build({ (genreRealm) in
            genreRealm.id = self.id
            genreRealm.name = self.name ?? ""
        })
    }
    
}

extension Genre: Codable{
    enum CodingKeys: String, CodingKey{
        case id
        case name
    }
}
