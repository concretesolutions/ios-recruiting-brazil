//
//  Genre.swift
//  movs
//
//  Created by Lorien Moisyn on 19/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation

class Genre: Codable {
    
    let id: Int!
    let name: String!
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
}
