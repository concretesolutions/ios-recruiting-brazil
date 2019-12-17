//
//  Genre.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

class Genre {
    var id: Int
    var name: String

    init(withGenre genre: GenreDTO) {
        self.id = genre.id
        self.name = genre.name
    }
}
