//
//  Movie.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 15/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import Foundation

class Movie: Decodable {
    
    // MARK: - Properties
    let name: String
    
    // MARK: - Decodable keys
    
    enum MovieDecodableKeys: String, CodingKey {
        case name
    }
    
    // MARK: - Inits
    
    init(name: String) {
        self.name = name
    }
    
    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieDecodableKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
     
        self.init(name: name)
    }
}
