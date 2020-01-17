//
//  Genre.swift
//  theMovie-app
//
//  Created by Adriel Alves on 19/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    var id: Int
    var name: String
    
}

struct GenreList: Codable {
    var genres: [Genre]
}
