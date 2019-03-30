//
//  Defines.swift
//  Movs
//
//  Created by Alexandre Papanis on 30/03/19.
//  Copyright © 2019 Papanis. All rights reserved.
//

import Foundation

struct Defines {
    static let baseURL = "https://api.themoviedb.org/3"
    static let baseImageURL = "https://image.tmdb.org/t/p/w780"
    
    static let language = "en-US"
    static let popularMovies = "/movie/popular"
    
    static let key = "1f54bd990f1cdfb230adb312546d765d"
    
}

enum ServiceError : Error {
    case failedToParse(String)
}


