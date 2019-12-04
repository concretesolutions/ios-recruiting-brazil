// swiftlint:disable identifier_name

//
//  GenreDTO.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class GenreDTO: Decodable {
    
    // MARK: - Attributes
    
    let id: Int
    let name: String

    // MARK: - Enums
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    // MARK: - Initializers and Deinitializers
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    required public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: GenreDTO.CodingKeys.self)
        
        let id: Int = try container.decode(Int.self, forKey: .id)
        let name: String = try container.decode(String.self, forKey: .name)
        
        self.init(id: id, name: name)
    }
}
