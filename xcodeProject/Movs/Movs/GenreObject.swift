//
//  GenreObject.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 12/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import Foundation

class GenreObject {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(from genre: Genre) {
        self.id = Int(genre.attrId)
        self.name = genre.attrName!
    }
}
