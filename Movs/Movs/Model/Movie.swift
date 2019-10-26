//
//  Movie.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class Movie {
    let id: UUID
    let title: String
    let posterPath: String
    
    init(withTitle title: String, andPoster posterPath: String) {
        self.id = UUID()
        self.title = title
        self.posterPath = posterPath
    }
}
