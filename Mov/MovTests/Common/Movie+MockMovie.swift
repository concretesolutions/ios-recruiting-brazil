//
//  Movie+MockMovie.swift
//  MovTests
//
//  Created by Miguel Nery on 02/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Foundation
@testable import Mov

extension Movie {
    static func mock(id: Int) -> Movie {
        return Movie(id: id, genreIds: [1, 2, 3], title: "title", overview: "overview", releaseDate: Date(), posterPath: "path")
    }
}
