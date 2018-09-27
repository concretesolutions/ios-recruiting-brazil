//
//  Genre.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Genre: NSObject {
    
    var genreId: Int
    var name: String
    
    override init() {
        genreId = 0
        name = ""
    }
    
    init(genreId: Int, name: String) {
        self.genreId = genreId
        self.name = name
    }
    init(genreId: Int) {
        self.genreId = genreId
        self.name = ""
    }
}
