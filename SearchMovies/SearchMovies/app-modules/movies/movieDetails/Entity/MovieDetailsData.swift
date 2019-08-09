//
//  MovieDetailsData.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 08/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

struct MovieDetailsData {
    var id:Int
    var name:String
    var year:Int
    var movieType:String
    var description:String
    
    init(id:Int, name:String, year:Int, movieType:String, description:String) {
        self.id = id
        self.name = name
        self.year = year
        self.movieType = movieType
        self.description = description
    }
}
