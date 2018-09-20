//
//  Result.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation

struct Result:Decodable{
    
    var movies:[Movie]?
    var genres:[Genre]?
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case genres = "genres"
    }
}
