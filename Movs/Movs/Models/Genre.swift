//
//  Genre.swift
//  Movs
//
//  Created by Maisa on 25/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import Foundation

struct Genre {
    let id: Int
    let name: String
}

extension Genre: Decodable {
    
    enum GenreCodingKey: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKey.self)
        
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }
    
}
