//
//  MovieDetailsData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct MovieDetailsData {
    var name:String
    var year:Int
    var movieType:String
    var description:String
    
    init(name:String, year:Int, movieType:String, description:String) {
        self.name = name
        self.year = year
        self.movieType = movieType
        self.description = description
    }
}
