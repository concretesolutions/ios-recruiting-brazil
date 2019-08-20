//
//  GenreMock.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/19/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation

@testable import MoviesApp

class GenreMock{
    var genres = [Genre]()
    
    init() {
        let genre = Genre(id: 28,name: "Action")
        let genre2 = Genre(id: 12, name: "Adventure")
        genres.append(contentsOf: [genre,genre2])
    }
}
