//
//  Genre.swift
//  Movies
//
//  Created by Renan Germano on 12/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import Foundation

class Genre: Decodable {
    
    // MARK: - Properties
    
    var id: Int
    var name: String
    
    // MARK: - Initializers
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}
