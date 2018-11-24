//
//  Genre.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 23/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    let id: Int
    let name: String
    
    private enum GenreCodingKeys: String, CodingKey {
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: GenreCodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}
