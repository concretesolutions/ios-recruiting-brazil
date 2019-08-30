//
//  Genres.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 26/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

struct Genres : Codable {
    let id : Int?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id         = try values.decodeIfPresent(Int.self, forKey: .id)
        name       = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
