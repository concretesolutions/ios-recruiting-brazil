//
//  Genre.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

class Genre {
    private(set) var id: Int
    private(set) var name: String

    init(withGenre genre: GenreDTO) {
        self.id = genre.id
        self.name = genre.name
    }
}
