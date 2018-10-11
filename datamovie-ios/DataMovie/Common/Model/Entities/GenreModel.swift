//
//  GenreModel.swift
//  DataMovie
//
//  Created by Andre Souza on 27/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

struct GenreModel: Decodable {
    
    var genreID: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case genreID = "id"
        case name    = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        genreID = try container.decodeIfPresent(Int.self, forKey: .genreID)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
}
