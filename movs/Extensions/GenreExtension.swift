//
//  GenreExtension.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Foundation

extension Genre {
    func toGenreData() -> GenreData {
        return GenreData(id: self.id, name: self.name)
    }
}

extension GenreObject {
    func toGenreData() -> GenreData {
        return GenreData(id: self.id, name: self.name)
    }
}
