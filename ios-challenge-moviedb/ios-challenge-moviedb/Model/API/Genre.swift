//
//  Genre.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 21/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import Foundation

/**
Model of Genre
 */
class Genre: Codable {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension Genre {
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
