//
//  Genre.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Genre: NSObject {

    var genreid: Int
    var name: String
    
    override init() {
        genreid = 0
        name = ""
    }
    
    init(genreid: Int, name: String) {
        self.genreid = genreid
        self.name = name
    }
}
