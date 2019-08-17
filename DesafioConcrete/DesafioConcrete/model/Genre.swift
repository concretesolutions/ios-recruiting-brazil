//
//  Genre.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//
import Foundation

struct Genre:Codable {
    var id:String
    var name:String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
    }
}

struct GenreResponse:Codable {
    var results:Array<Genre>
    
    enum CodingKeys: String, CodingKey {
        case results = "genres"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.results = try values.decode(Array<Genre>.self, forKey: .results)
    }
}

