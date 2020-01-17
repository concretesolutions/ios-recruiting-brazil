//
//  Movie.swift
//  theMovie-app
//
//  Created by Adriel Alves on 17/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import Foundation

struct Movie: Codable {
    
    var id: Int64
    var title: String = ""
    var genreIds: [Int] = []
    var overview: String = ""
    var releaseDate: String?
    var posterPath: String
    
  
}
