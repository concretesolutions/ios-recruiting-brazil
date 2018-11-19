//
//  Genre.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation

struct Genre:Codable{
    var id:Int
    var name:String
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
    }
}
