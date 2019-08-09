//
//  Genre.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct GenreData {
    var id:Int
    var name:String
    
    init(id:Int, name:String) {
        self.id = id
        self.name = name
    }
}

extension GenreData:Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder:Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let codeDecodable = try container.decode(Int.self, forKey: .id)
        let nameDecodable = try container.decode(String.self, forKey: .name)
        
        self.init(id: codeDecodable, name: nameDecodable)
    }
}
