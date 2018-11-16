//
//  Genres.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import Foundation

class Genre: Decodable {
    
    // MARK: - Properties
    let id: Int
    let name: String
    
    // MARK: - Decodable Keys
    enum GenreCodingKey: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    // MARK: - Inits
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreCodingKey.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        
        self.init(id: id, name: name)
    }
}
