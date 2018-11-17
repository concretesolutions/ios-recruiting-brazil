//
//  Genre.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct Genre {
    let id: Int?
    let name: String?
}

extension Genre: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
