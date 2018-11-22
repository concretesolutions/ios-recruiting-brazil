//
//  GenreList.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import Foundation

struct GenreList {
    let list: [Genre]?
}

extension GenreList: Codable {
    enum CodingKeys: String, CodingKey {
        case list = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decodeIfPresent([Genre].self, forKey: .list)
    }
    
}
