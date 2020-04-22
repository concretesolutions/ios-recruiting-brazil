//
//  Genre.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 19/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import Foundation

struct Genre: Codable, Equatable {
    let id: Int
    let name: String
    
    static func ==(lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
