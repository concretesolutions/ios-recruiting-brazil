//
//  ProductionCompanies.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 26/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation

struct ProductionCompanies : Codable {
    let id : Int?
    let logo_path : String?
    let name : String?
    let origin_country : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case logo_path = "logo_path"
        case name = "name"
        case origin_country = "origin_country"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        logo_path = try values.decodeIfPresent(String.self, forKey: .logo_path)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        origin_country = try values.decodeIfPresent(String.self, forKey: .origin_country)
    }
    
}
