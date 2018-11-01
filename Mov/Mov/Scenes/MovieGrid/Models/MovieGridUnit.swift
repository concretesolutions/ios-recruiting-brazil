//
//  MovieGridMovie.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation

struct MovieGridUnit {
    let id: Int
    let title: String
    let posterPath: String
    let isFavorite: Bool
}

extension MovieGridUnit: Equatable {
    static func == (lhs: MovieGridUnit, rhs: MovieGridUnit) -> Bool {
        return lhs.id == rhs.id
            && lhs.isFavorite == rhs.isFavorite
    }
}
