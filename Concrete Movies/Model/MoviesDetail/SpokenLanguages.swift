//
//  SpokenLanguages.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 26/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

struct Spoken_languages : Codable {
    let iso_639_1 : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case iso_639_1 = "iso_639_1"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
