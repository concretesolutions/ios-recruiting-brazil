//
//  Genres.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 14/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

struct Genres: Decodable {
    let name: String
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let name = try container.decode(String.self, forKey: .name)
        let id = try container.decode(Int.self, forKey: .id)
        self.init(name: name, id: id)
    }
    
}
