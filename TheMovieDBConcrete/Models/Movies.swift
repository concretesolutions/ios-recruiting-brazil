//
//  Movies.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Movies: NSObject {

    var name = ""
    var movieDescription = ""
    
    init (name: String , movieDescription: String) {
        self.name = name
        self.movieDescription = movieDescription
    }
    
    override init() {
        self.name = ""
        self.movieDescription = ""
    }
}
